//
//  PostViewSwipeableInstagramViewLayout.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 17/12/21.
//

import SwiftUI

struct PostViewSwipeableInstagramViewLayout: View {
    @Binding var offset : CGFloat
    var body: some View {
        ZStack{
//            Camera View...
//            will Be Implemented later...
            
            Color.black
            
            CustomCameraSwipeableInstagramViewLayout(offset: $offset)
            
            VStack{
                HStack{
                    Button {
                        
                    } label: {
                        Image(systemName: "gear")
                            .font(.title)
                    }
                    
                    Spacer()
                    
                    Button {
                        offset = rectSwipeableInstagramViewLayout.width
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title)
                    }
                }
                .foregroundColor(.white)
                .padding()
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "photo")
                        .font(.title)
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
            }
            .padding(.top,edgesSwipeableInstagramViewLayout?.top ?? 15)
            .padding(.bottom,edgesSwipeableInstagramViewLayout?.bottom)
        }
    }
}

struct PostViewSwipeableInstagramViewLayout_Previews: PreviewProvider {
    static var previews: some View {
        MainViewSwipeableInstagramViewLayout()
    }
}
