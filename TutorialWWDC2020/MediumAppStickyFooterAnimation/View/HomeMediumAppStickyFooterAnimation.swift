//
//  HomeMediumAppStickyFooterAnimation.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 17/12/21.
//

import SwiftUI

struct HomeMediumAppStickyFooterAnimation: View {
    
//    Splits Array Of Article Into Two...
    
    var split_Article: [[String]] {
        
        let Mid = articleParagraphs.count / 2
        
        var splitArray1 : [String] = []
        var splitArray2 : [String] = []

        for index in 0..<Mid - 1 {
            splitArray1.append(articleParagraphs[index])
        }
        
        for index in Mid..<articleParagraphs.count {
            splitArray2.append(articleParagraphs[index])
        }
        
        return [splitArray1,splitArray2]
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 15, pinnedViews: [.sectionFooters]) {
             
                Section {
                    Text("I never wanted to post about this online, but...")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.primary)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
    //                profile view...
                    
                    HStack(spacing: 15){
                        Image("p1")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 55, height: 55)
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Michele")
                                .foregroundColor(.green)
                            
                            Text("21 Mar 2020 . 4 Min Read")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                                .font(.title2)
                                .foregroundColor(.gray)
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "bookmark")
                                .font(.title2)
                                .foregroundColor(.gray)
                        }
                        
                        
                    }
                    .padding(.horizontal)
                    
    //                Article Paragraphs...
                    
    //                Splitting Article To Insert Image In Mid OF Article...
                    
                    ForEach(split_Article[0],id:\.self){ article in
                        Text(article)
                            .foregroundColor(.primary)
                            .padding(.horizontal)
                            .padding(.top,10)
                    }
                    
    //                Article Image...
                    Image("article_img1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .padding(.horizontal)
                        .padding(.top,10)
                    
    //                Remaining Article...
                    
                    ForEach(split_Article[1],id:\.self){ article in
                        Text(article)
                            .foregroundColor(.primary)
                            .padding(.horizontal)
                            .padding(.top,10)
                    }
                    
    //                Article End Image...
                    Image("article_img2")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .padding(.horizontal)
                            .padding(.top,10)
                } footer: {
                    FooterViewMediumAppStickyFooterAnimation()
                }
                
//                Fetured content...
                Text("Featured")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.primary)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinit, alignment: .leading)
                
//                Feature Rows...
                
                FeatureContentMediumAppStickyFooterAnimation()
                    .padding(.bottom)

            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

struct HomeMediumAppStickyFooterAnimation_Previews: PreviewProvider {
    static var previews: some View {
        HomeMediumAppStickyFooterAnimation()
    }
}

struct FeatureContentMediumAppStickyFooterAnimation: View {
    var body: some View{
        VStack(spacing: 15){
            HStack(spacing: 15){
                
                Image("p1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 70, height: 70)
                    .cornerRadius(10)
                
                Text("One of people's biggest fears is chnge.")
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 15){
                
                Image("p2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 70, height: 70)
                    .cornerRadius(10)
                
                Text("I recently shot this amazing 370 Virtual Reality video for my YouTube")
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 15){
                
                Image("p3")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 70, height: 70)
                    .cornerRadius(10)
                
                Text("One of people's biggest fears is chnge.")
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
    }
}
