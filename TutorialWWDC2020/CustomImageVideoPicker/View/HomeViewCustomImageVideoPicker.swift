//
//  HomeViewCustomImageVideoPicker.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 18/12/21.
//

import SwiftUI
import AVKit

struct HomeViewCustomImageVideoPicker: View {
    
    @State var message = ""
    
    @StateObject var imagePicker = ImageViewModelCustomImageVideoPicker()
    
    var body: some View {
        NavigationView{
            
//            Sample Signal Chat View...
            
            VStack{
                
                ScrollView{
                    
                }
                
                VStack {
                    
                    HStack(spacing: 15){
                        Button {
                            imagePicker.openImagePicker()
                        } label: {
                            Image(systemName: imagePicker.showImagePicker ? "xmark" : "plus")
                                .font(.title2)
                                .foregroundColor(.gray)
                        }
                        
                        TextField("New Message",text: $message,onEditingChanged: { opened in
                            if opened && imagePicker.showImagePicker{
//                                Closing Picker...
                                withAnimation {
                                    imagePicker.showImagePicker.toggle()
                                }
                            }
                        })
                            .padding(.vertical,10)
                            .padding(.horizontal)
                            .background(Color.primary.opacity(0.06))
                            .clipShape(Capsule())
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "camera")
                                .font(.title2)
                                .foregroundColor(.gray)
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "mic")
                                .font(.title2)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom,4)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15){
                            
//                            Images...
                            
                            ForEach(imagePicker.fetchedPhotos){photo in
                                ThmbnailViewCustomImageVideoPicker(photo: photo)
                                    .onTapGesture {
                                        imagePicker.extractPreviewData(asset: photo.asset)
                                        imagePicker.showPreview.toggle()
                                    }
                            }
                            
//                            More Or Give Access Button..
                            
                            if imagePicker.library_status == .denied || imagePicker.library_status == .limited{
                                VStack(spacing: 10){
                                    Text(imagePicker.library_status == .denied ? "Allow Access for Photos" : "Selected More Photos")
                                        .foregroundColor(.gray)
                                    
                                    Button {
//                                        Go to Settings...
                                        UIApplication.shared.open(
                                            URL(string: UIApplication.openSettingsURLString)!,
                                            options: [:],
                                            completionHandler: nil)
                                    } label: {
                                        Text(imagePicker.library_status == .denied ? "Allow Access" : "Select More")
                                            .foregroundColor(.white)
                                            .fontWeight(.bold)
                                            .padding(.vertical,10)
                                            .padding(.horizontal)
                                            .background(Color.blue)
                                            .cornerRadius(5)
                                    }
                                }
                                .frame(width: 150)
                            }
                        }
                        .padding()
                    }
//                    Showing When button Clicked...
                    .frame(height: imagePicker.showImagePicker ? 200 : 0)
                    .background(Color.primary.opacity(0.04).ignoresSafeArea(.all,edges: .bottom))
                    .opacity(imagePicker.showImagePicker ? 1 : 0)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
//                Back Button....
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                }
                
//                Profile...
                ToolbarItem(id: "PROFILE", placement: .navigationBarLeading, showsByDefault: true) {
                    HStack(spacing: 8){
                        
//                        Use Your Image Or Profile Image Here..
                        Circle()
                            .fill(Color.purple)
                            .frame(width: 35, height: 35)
                            .overlay(
                                Text("M")
                                    .font(.callout)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            )
                        
                        Text("Michele")
                            .fontWeight(.semibold)
                        
                        Image(systemName: "person.circle")
                            .font(.caption)
                    }
                }
                
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "camera")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "phone")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                }
                
            }
        }
//        Colors will not work on navigation bar...
//        but use accent color to change...
        .accentColor(.primary)
        .onAppear {
            imagePicker.setUp()
        }
        .sheet(isPresented: $imagePicker.showPreview) {
//            Clearing Content...
            imagePicker.selectedVideoPreview = nil
            imagePicker.selectedImagePreview = nil
        } content: {
            PreviewViewCustomImageVideoPicker()
                .environmentObject(imagePicker)
        }

    }
}

// Preview View...

struct PreviewViewCustomImageVideoPicker:View {
    @EnvironmentObject var imagePicker: ImageViewModelCustomImageVideoPicker
    
    var body: some View{
    
//        For Top Buttons...
        NavigationView{
            ZStack{
                if imagePicker.selectedVideoPreview != nil{
                    VideoPlayer(player: AVPlayer(playerItem: AVPlayerItem(asset: imagePicker.selectedVideoPreview)))
                }
                
                if imagePicker.selectedImagePreview != nil{
                    Image(uiImage: imagePicker.selectedImagePreview)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
            .ignoresSafeArea(.all, edges: .bottom)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Text("Send")
                    }

                }
            }
        }
    }
}

struct ThmbnailViewCustomImageVideoPicker: View {
    var photo: AssetCustomImageVideoPicker
    
    var body: some View{
        ZStack(alignment: .bottomTrailing) {
            
            Image(uiImage: photo.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .cornerRadius(10)
            
//            If its Video
//            Displaying Video Icon...
            
            if photo.asset.mediaType == .video{
                Image(systemName: "video.fill")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(8)
            }
            
            
        }
    }
    
}

struct HomeViewCustomImageVideoPicker_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewCustomImageVideoPicker()
    }
}
