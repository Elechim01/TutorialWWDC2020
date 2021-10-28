//
//  ViewGif.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 27/10/21.
//

import SwiftUI
import SDWebImageSwiftUI


struct ViewGif: View {
    
    //    Gif Data...
    @State var gifData : [String] = []
    @State var present = false
    @State var url = ""
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(gifData,id: \.self){ url in
                    HStack{
                        Spacer(minLength: 0)
                        //                    Animated image with log giff...
                        AnimatedImage(url: URL(string: url)!)
//                        For perfect Fit...
                            .aspectRatio(contentMode: .fit)
//                            .resizable()
//                            .frame(width: UIScreen.main.bounds.width - 100, height: 200)
                            .clipShape(CustomShapeGif())
                    }
                    .padding()
                }
                .onChange(of: url) { value in
                    //                whenever url changes...
                    //                adding to array..
                    self.gifData.append(value)
                }
                .navigationTitle("GIF's")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button {
                        present.toggle()
                    } label: {
                        Image(systemName: "rectangle.and.pencil.and.ellipsis")
                            .font(.title)
                    }
                    
                }
            }
            .fullScreenCover(isPresented: $present) {
                GIFController(url: $url, present: $present)
            }
        }
    }
}

struct ViewGif_Previews: PreviewProvider {
    static var previews: some View {
        ViewGif()
    }
}

struct CustomShapeGif : Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight,.bottomLeft], cornerRadii: CGSize(width: 35, height: 35))
        return Path(path.cgPath)
    }
}
