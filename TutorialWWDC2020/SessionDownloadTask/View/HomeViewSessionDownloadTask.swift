//
//  HomeViewSessionDownloadTask.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 23/12/21.
//

import SwiftUI

struct HomeViewSessionDownloadTask: View {
    
    @StateObject var downloadModel = DownloadTaskModelSessionDownloadTask()
    @State var urlText = ""
    
    var body: some View {
        
        NavigationView{
        
            VStack(spacing: 15){
                
                TextField("URL", text: $urlText)
                    .padding(.vertical,10)
                    .padding(.horizontal)
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(color: Color.black.opacity(0.06), radius: 5, x: 5, y: 5)
                    .shadow(color: Color.black.opacity(0.06), radius: 5, x: -5, y: -5)
                
//                Download Button..
                Button {
                    downloadModel.startDownload(urlString: urlText)
                } label: {
                    Text("Download URL")
                        .fontWeight(.semibold)
                        .padding(.vertical,10)
                        .padding(.horizontal,30)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
                .padding(.top)

            }
            .padding()
//            Navigation Bar Title
            .navigationTitle("Download Task")
        }
//        Alwasy Light Mode...
        .preferredColorScheme(.light)
//        Alert...
        .alert(isPresented: $downloadModel.showAlert) {
            Alert(title: Text("Message"), message: Text(downloadModel.alertMsg), dismissButton: .destructive(Text("OK"),action: {
                
            }))
        }
        .overlay(
            ZStack{
                if downloadModel.showDownloadProgess{
                    DownloadProgressViewSessionDownloadTask(progress: $downloadModel.downloadProgress)
                        .environmentObject(downloadModel)
                }
            }
        )
    }
}

struct HomeViewSessionDownloadTask_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewSessionDownloadTask()
    }
}
