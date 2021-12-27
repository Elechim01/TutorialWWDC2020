//
//  HomeViewInstagramProfileStickyHeader.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 26/12/21.
//

import SwiftUI

struct HomeViewInstagramProfileStickyHeader: View {
//    First Tab Image..
    @State var selectedTab: String = "square.grid.3x3"
//    For Smooth Sliding Effect
    @Namespace var animation
    
//    For Dark Mode Adoption...
    @Environment(\.colorScheme) var scheme
    
//    Offset For Sticky Segment Picker...
    @State var topheaderOffset: CGFloat = 0
    
    var body: some View {
        
        VStack{
            
            HStack(spacing: 15){
                
                Button {
                    
                } label: {
                    Text("_kavasoft")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                }
                
                Spacer(minLength: 0)
                
                Button {
                    
                } label: {
                    Image(systemName: "plus.app")
                        .font(.title)
                        .foregroundColor(.primary)
                }
                
                Button {
                    
                } label: {
                    Image(systemName: "line.horizontal.3")
                        .font(.title)
                        .foregroundColor(.primary)
                }


            }
            .padding([.horizontal,.top])
            .overlay(
                
//           logic is when the piker reaches the header Bottom then were sticking the picker to header...
                
                GeometryReader{ proxy -> Color in
                    
                    let minY = proxy.frame(in:.global).minY
                    
                    DispatchQueue.main.async {
                        if topheaderOffset == 0{
                            topheaderOffset = minY
                        }
                    }
                    return Color.clear
                }
                    .frame(width: 0, height: 0)
                
//                Since we need bottom value...
                ,alignment: .bottom
            )
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack{
                    Divider()
                    
                    HStack{
                        
//                        Plus Button At Right Bottom
                        Button {
                            
                        } label: {
                            Image("p1")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 70, height: 70)
                                .overlay(
                                
                                    Image(systemName: "plus")
                                        .foregroundColor(.white)
                                        .padding(6)
                                        .background(Color.blue)
                                        .clipShape(Circle())
                                        .padding()
                                        .background(Color.white)
                                        .clipShape(Circle())
                                        .offset(x: 5, y: 5)
                                    
                                    ,alignment: .bottomTrailing
                                )
                        }
                        
                        VStack{
                            
                            Text("199")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                            
                            Text("Posts")
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity)
                        
                        VStack{
                            
                            Text("1,129")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                            
                            Text("Followers")
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity)
                        
                        VStack{
                            
                            Text("13")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                            
                            Text("Following")
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity)

                    }
                    .padding()
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Michele sportivo e IOS & SwiftUI Dev")
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        
                        Text("Video Creator")
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                        
                        Text("Ciao Bello")
                        
                        Link(destination: URL(string: "https://www.apple.com")!) {
                            Text("Apple")
                        }
                    }
                    .padding(.horizontal)
                    
//                    Edit Profile Button...
                    HStack(spacing: 10){
                        
                        Button {
                            
                        } label: {
                            Text("Edit Profile")
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                                .padding(.vertical,10)
                                .frame(maxWidth: .infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(Color.gray)
                                )
                        }
                        
                        Button {
                            
                        } label: {
                            Text("Promotion's")
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                                .padding(.vertical,10)
                                .frame(maxWidth: .infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(Color.gray)
                                )
                        }

                    }
                    .padding([.horizontal,.top])
                    
                    
//                    Stories Section....
                    ScrollView(.horizontal,showsIndicators: false){
                        
                        HStack(spacing: 15){
                        
                            Button {
                                
                            } label: {
                                
                                VStack{
                                    Image(systemName: "plus")
                                        .font(.title2)
                                        .foregroundColor(.primary)
                                        .padding(18)
                                        .background(Circle().stroke(Color.gray))
                                    
                                    Text("New")
                                        .foregroundColor(.primary)
                                }
                            }
                        }
                        .padding([.horizontal,.top])
                    }
                    
                    GeometryReader{ proxy -> AnyView in
                        
                        let minY = proxy.frame(in: .global).minY
                        
                        let offset = minY - topheaderOffset
                        
                        print(offset)
                        
                        print("\(topheaderOffset) = \(minY)")
                        
                        return AnyView(
                            //                    Sticky Top Segmented Bar...
                            HStack(spacing: 0){
                                TabBarButtonInstagramProfileStickyHeader(image: "square.grid.3x3", isSystemImage: true, animation: animation, selectedTab: $selectedTab)
                                
                                TabBarButtonInstagramProfileStickyHeader(image: "reels", isSystemImage: false, animation: animation, selectedTab: $selectedTab)
                                
                                TabBarButtonInstagramProfileStickyHeader(image: "person.crop.square", isSystemImage: true, animation: animation, selectedTab: $selectedTab)
                            }
//                       Max Frame...
//                       Conisered as padding..
                            .frame(height: 70,alignment: .bottom)
                            .background(scheme == .dark ? Color.black : Color.white)
                                .offset(y: offset < 0 ? -offset : 0)
                        )
                    }
                    .frame(height: 70)
//                    Moving View to top...
                    .zIndex(4)
                    
//                    your Tab Views...
                    ZStack{
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 2), count: 3),spacing: 2) {
                            
                            ForEach(1...30,id:\.self){ index in
                                
//                                For Getting Width For Image..
                                GeometryReader{ proxy in
                                    
                                    let width = proxy.frame(in: .global).width
                                    
                                    ImageViewInstagramProfileStickyHeader(index: index, width: width)
                                    
                                }
                                .frame(height: 120)
                            }
                        }
                        
                    }
                }
            }
        }
    }
}

struct ImageViewInstagramProfileStickyHeader: View {
    var index: Int
    var width: CGFloat
    
    var body: some View{
        
        VStack {
            
//            Looping Image...
            let imageName = index > 10 ?  index - (10 * (index / 10)) == 0 ? 10 : index - (10 * (index / 10)) : index
            
            Image("p\(imageName)")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: 120)
    //                                 Image Problemm
    //                                  If use corenrradius it will solve...
            .cornerRadius(0)
        }
    }
}

struct HomeViewInstagramProfileStickyHeader_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewInstagramProfileStickyHeader()
    }
}

struct TabBarButtonInstagramProfileStickyHeader: View{
    
    var image: String
//    Since we're having asset Image...
    var isSystemImage: Bool
    var animation: Namespace.ID
    @Binding var selectedTab: String
    
    var body: some View{
        
        Button {
            withAnimation(.easeInOut){
                selectedTab = image
            }
        } label: {
            VStack(spacing: 12){
                
                (
                    isSystemImage ? Image(systemName: image) : Image(image)
                )
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 28, height: 28)
                .foregroundColor(selectedTab == image ? .primary : .gray)
                
                ZStack{
                    
                    if selectedTab == image{
                        Rectangle()
                            .fill(Color.primary)
//                        For Smooth sliding effect...
                            .matchedGeometryEffect(id: "TAB", in: animation)
                    }else{
                        Rectangle()
                            .fill(Color.clear)
                    }
                }
                .frame(height: 1)
            }
        }

    }
}
