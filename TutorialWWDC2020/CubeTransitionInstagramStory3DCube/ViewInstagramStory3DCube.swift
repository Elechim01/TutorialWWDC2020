//
//  ViewInstagramStory3DCube.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 30/09/21.
//

import SwiftUI

struct ViewInstagramStory3DCube: View {
    var width = UIScreen.main.bounds.width
    var body: some View {
        TabView{
            ForEach(dataStory){ story in
//                going to add cubic transition...
                GeometryReader{ g in
                    ZStack{
                        LinearGradient(gradient: .init(colors: [Color("Colorsh1"),story.color]), startPoint: .top, endPoint: .bottomTrailing)
                            .cornerRadius(10)
                        
                        Image(story.story)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.horizontal)
                        VStack(alignment: .leading, spacing: 12) {
                            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                                Capsule()
                                    .fill(Color.black.opacity(0.3))
                                    .frame(height: 2.5)
                                Capsule()
                                    .fill(Color.white)
                                    .frame(width: story.offset,height: 2.5)
                            }
                            
                            HStack(spacing: 12){
                                Image(story.story)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                Text(story.name)
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                Text(story.time)
                                    .foregroundColor(.white)
                            }
                            Spacer()
                        }
                        .padding(.all)
                    }
//                    setting frame
                    .frame(width: g.frame(in: .global).width, height: g.frame(in: .global).height)
//                    rotating view for animation....
                    .rotation3DEffect( .init(degrees: getAngle(xOffset: g.frame(in: .global).minX)),
                                       axis: (x: 0.0,y: 1.0,z: 0.0),
                                       anchor: g.frame(in: .global).minX > 0 ? .leading : .trailing,
                                       perspective: 2.5)
                }
              
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
    func getAngle(xOffset : CGFloat) -> Double {
//        since each view is placed at center...
//        so half the width is used to caluclate the degree...
        let tempAngle = xOffset / (width / 2)
        let rotationDegree : CGFloat = 25
//        you can give yur own rotation angle...
        return Double(tempAngle * rotationDegree)
    }
}

struct ViewInstagramStory3DCube_Previews: PreviewProvider {
    static var previews: some View {
        ViewInstagramStory3DCube()
    }
}

//sample data...
struct Story: Identifiable {
    var id = UUID().uuidString
    var story : String
    var name : String
    var time : String
    var offset : CGFloat
    var color: Color
}
var dataStory = [
    Story(story: "p1", name: "michele", time: "1h", offset: 100, color: .yellow),
    Story(story: "p2", name: "michele", time: "1h", offset: 100, color: .blue),
    Story(story: "p3", name: "michele", time: "1h", offset: 100, color: .black),
    Story(story: "p4", name: "michele", time: "1h", offset: 100, color: .gray),
    Story(story: "p5", name: "michele", time: "1h", offset: 100, color: .purple),
    
]
