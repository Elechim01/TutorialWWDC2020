//
//  ViewViewBuilderCustomViews.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 18/11/21.
//

import SwiftUI

struct ViewViewBuilderCustomViews: View {
    var body: some View {
        NavigationView{
            HomeViewBuilderCustomViews()
                .padding(.top)
                .navigationTitle("View Builders")
                .preferredColorScheme(.dark)
        }
    }
}

struct ViewViewBuilderCustomViews_Previews: PreviewProvider {
    static var previews: some View {
        ViewViewBuilderCustomViews()
    }
}

struct HomeViewBuilderCustomViews: View {
    
    @State var columns = Array(repeating: GridItem(.flexible(),spacing: 15), count: 2)
    
    @StateObject var ModelData = HomeViewModelBuilderCustomViews()
    
    @State var width = (UIScreen.main.bounds.width - 45) / 2
    
    var body: some View{
        ScrollView{
            LazyVGrid(columns: columns,spacing: 15) {
                ForEach(ModelData.items,id:\.album_name) { album in
//                    Going to Build Custom View using Builder...
                    
//                    Our Content goes Here...
                    CustomViewViewBuilderCustomView(columns: $columns) {
                        Image(album.album_cover)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: columns.count == 1 ? 65 : width, height: columns.count == 1 ? 65 : width)
                            .cornerRadius(15)
                    } detail: {
                        VStack(alignment: .leading, spacing: 10) {
                            
                            Text(album.album_name)
                                .fontWeight(.heavy)
                            
                            Text(album.album_author)
                                .font(.caption)
                                .fontWeight(.heavy)
                                .foregroundColor(.gray)
                            
                        }
                    }

                }
            }
        }
        .toolbar {
            Button {
                
                withAnimation {
                    if columns.count == 2{columns.removeLast()}
                    else{columns.append(GridItem(.flexible(),spacing: 15))}
                }
                
            } label: {
                Image(systemName: columns.count == 1 ? "rectangle.3.offgrid" : "rectangle.grid.1x2")
                    .font(.title)
                    .foregroundColor(.white)
            }

        }
    }
}
