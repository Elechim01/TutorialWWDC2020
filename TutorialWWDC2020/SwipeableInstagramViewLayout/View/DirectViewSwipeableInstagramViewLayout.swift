//
//  DirectViewSwipeableInstagramViewLayout.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 17/12/21.
//

import SwiftUI

struct DirectViewSwipeableInstagramViewLayout: View {
    
    @Binding var offset: CGFloat
    @State var search = ""
    
    var body: some View {
        
        VStack{
         
            HStack(spacing: 15){
                
                Button {
                    offset = rectSwipeableInstagramViewLayout.width
                } label: {
                    HStack{
                        Image(systemName: "chevron.left")
                            .font(.system(size: 24, weight: .bold))
                        
                        Text("Direct")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "video")
                        .font(.title)
                }
                
                Button {
                    
                } label: {
                    Image(systemName: "square.and.pencil")
                        .font(.title)
                }


            }
            .foregroundColor(.primary)
            .padding()
            
            ScrollView{
                
                VStack(spacing: 15){
                    HStack(spacing: 15){
                        
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Search", text: $search)
                    }
                    .padding(.vertical,10)
                    .padding(.horizontal)
                    .background(Color.primary.opacity(0.06))
                    .cornerRadius(12)
                    
                    ForEach(postSwipeableInstagramViewLayout){ post in
                        
                        HStack(spacing: 15){
                            Image(post.profile)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 55, height: 55)
                                .clipShape(Circle())
                            
                            Text(post.user)
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "camera")
                                    .font(.title)
                            }
                            .foregroundColor(.gray)

                        }
                        .padding(.top,8)
                    }
                }
                .padding()
                
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top,edgesSwipeableInstagramViewLayout?.top ?? 15)
        .padding(.bottom,edgesSwipeableInstagramViewLayout?.bottom ?? 15)
    }
}

struct DirectViewSwipeableInstagramViewLayout_Previews: PreviewProvider {
    static var previews: some View {
        MainViewSwipeableInstagramViewLayout()
    }
}
