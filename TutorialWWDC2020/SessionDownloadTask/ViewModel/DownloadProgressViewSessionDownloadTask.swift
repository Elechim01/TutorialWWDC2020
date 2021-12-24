//
//  DownloadProgressViewSessionDownloadTask.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 23/12/21.
//

import SwiftUI

struct DownloadProgressViewSessionDownloadTask: View {
    @Binding var progress: CGFloat
    @EnvironmentObject var downloadModel: DownloadTaskModelSessionDownloadTask
    var body: some View {
        ZStack{
            
            Color.primary
                .opacity(0.25)
                .ignoresSafeArea()
            
            VStack(spacing: 15){
                
                ZStack{
                    
//                    Custom Circle progress View..
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                    
                    ProgressShapeSessionDownloadTask(progress: progress)
                        .fill(Color.gray.opacity(0.4))
                        .rotationEffect(.init(degrees: -90))
                }
                .frame(width: 70, height: 70)
                
//                Cancell Button...
                Button {
                    downloadModel.cancelTask()
                } label: {
                    Text("Cancel")
                        .fontWeight(.semibold)
                }
                .padding(.top)

            }
            .padding(.vertical,20)
            .padding(.horizontal,50)
            .background(Color.white)
            .cornerRadius(8)
        }
    }
}

struct DownloadProgressViewSessionDownloadTask_Previews: PreviewProvider {
    static var previews: some View {
        DownloadProgressViewSessionDownloadTask(progress: .constant(0.5))
    }
}

//Custom progress shape..
struct ProgressShapeSessionDownloadTask:Shape{
    
    var progress: CGFloat
    
    func path(in rect: CGRect) -> Path {
        
        return Path{ path in
            path.move(to: CGPoint(x: rect.midX, y: rect.midY))
            path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: 35, startAngle: .zero, endAngle: .init(degrees: Double(progress * 360)), clockwise: false)
        }
    }
}
