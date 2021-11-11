 //
//  ViewParallaxScrollingEffectWithStickyTopHeader.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 11/11/21.
//

import SwiftUI

struct ViewParallaxScrollingEffectWithStickyTopHeader: View {
    var body: some View {
        NavigationView{
            HomeViewParallaxScrollingEffectWithStickyTopHeader()
                .preferredColorScheme(.dark)
                .navigationBarHidden(true)
        }
    }
}

struct ViewParallaxScrollingEffectWithStickyTopHeader_Previews: PreviewProvider {
    static var previews: some View {
        ViewParallaxScrollingEffectWithStickyTopHeader()
    }
}

struct HomeViewParallaxScrollingEffectWithStickyTopHeader: View  {
    
    let maxHeight = UIScreen.main.bounds.height / 2.3
    @State var show = false
    
//    Row To Grid animations...
    @State var columns = Array(repeating: GridItem(.flexible(),spacing: 15), count: 1)
    
    var body: some View{
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
            
            ScrollView(.vertical, showsIndicators: false) {
            VStack{
                
//                Parallaax Effect...
                GeometryReader{ reader -> AnyView in
                    
//                    Anyview can be used to return Geometry Reader Property...
//                    checking if top scroll...
                    
                    let y = reader.frame(in: .global).minY + maxHeight
                    
                    if y < 0 {
//                        TogglingTop Sticky Header...
                        withAnimation(.linear){ show = true}
                    }else{
                        withAnimation(.linear){show = false}
                    }
                    
                    return AnyView(
                        Image("g8")
                           .resizable()
                           .frame(height: maxHeight)
//                        avoid bottom scroll...
                            .offset(y: -reader.frame(in: .global).minY)
                    )
                }
                .frame(height: maxHeight)
                
               LazyVGrid(columns: columns,spacing: 25){
                    ForEach(albumsParallax,id:\.album_name) { album in
                        AlbumRowParallaxScrollingEffectWithStickyTopHeader(album: album, columns: $columns)
                    }
                }
               .padding()
                .background(Color.black)
                .cornerRadius(15)
                
            }
        }
            
//            Sticky Header...
            HStack(spacing: 15){
                Image("g10")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 65, height: 65)
                    .cornerRadius(15)
                
                VStack(alignment: .leading, spacing: 4) {
                    
                    Text("Now Playing")
                        .font(.title2)
                        .fontWeight(.heavy)
                    
                    Text("Lover - Xerox world")
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                }
                
                Spacer(minLength: 0)
                
//                Buttons...
                Button {
                    
                } label: {
                    Image(systemName: "pause.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                
                Button {
                    if columns.count == 2 {columns.removeLast()}
                    else{columns.append(GridItem(.flexible(),spacing: 15))}
                } label: {
                    Image(systemName: columns.count == 2 ? "rectangle.grid.1x2" : "rectangle.3.offgrid")
                        .font(.title2)
                        .foregroundColor(.white)
                }
            }
            .padding([.horizontal,.bottom])
            .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
            .background(BlurViewParallaxScrollingEffectWithStickyTopHeader(style: .systemMaterialDark))
            .opacity(show ? 1 : 0)
        }
        .ignoresSafeArea(.all, edges: .top)
    }
}
