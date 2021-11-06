//
//  ViewDetailSmoothCurves.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 04/11/21.
//

import SwiftUI

struct ViewDetailSmoothCurves: View {
    
//    Dismisss..
    @Environment(\.presentationMode) var present
    @State var isSmallDevice = UIScreen.main.bounds.width < 750
    
    var body: some View {
        VStack{
            HStack{
                Button {
                    present.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color.black.opacity(0.6))
                }
                
                Spacer(minLength: 0)

            }
            .padding([.horizontal,.top])
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Party Dount")
                    .font(.system(size: isSmallDevice ? 35 : 50, weight:.heavy))
                    .foregroundColor(Color("SmoothC3"))
                
                Text("36$")
                    .font(.system(size: isSmallDevice ? 25 : 40, weight: .heavy))
                    .foregroundColor(Color.black.opacity(0.6))
            }
            .padding(.top)
            
            VStack{
                HStack(alignment: .top, spacing: 20) {
                    VStack(alignment: .leading, spacing: 10) {
                        Image("p1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 100)
                        
                        Text("Available to order")
                            .fontWeight(.bold)
                            .foregroundColor(Color.black.opacity(0.6))
//                        default frame..
                            .frame(height: 50)
                        
                        Text("129")
                            .font(.title2)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding(.vertical,10)
                            .padding(.horizontal)
                            .background(Color("SmoothC3"))
                            .cornerRadius(10)
                    }
                    
                    Image("p2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width / 2)
                        .offset(y: isSmallDevice ? 20 : -20)
                        .padding(.top,-25)
                }
                Text("jiorjfoierfjirefhdvnjoirhjviodjvòihgjvòijògnveriojveiòon")
                    .fontWeight(.heavy)
                    .foregroundColor(Color.black.opacity(0.6))
                    .multilineTextAlignment(.leading)
                    .padding(.top)
                
                Spacer(minLength: 0)
                
                HStack(spacing: 20){
                    Button {
                        
                    } label: {
                        Image(systemName: "suit.heart.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color("SmoothC3"))
                            .clipShape(Circle())
                    }
                    
                    Button {
                        
                    } label: {
                        HStack(spacing: 10){
                            Text("Go to order donut")
                                .font(isSmallDevice ? .none : .title2)
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                            
                            Image(systemName: "chevron.right")
                                .font(.system(size: isSmallDevice ? 15 : 22, weight: .heavy))
                                .foregroundColor(.white)
                        }
                        .padding(.vertical,10)
                        .padding(.horizontal)
                        .background(Color("SmoothC3"))
                        .clipShape(Capsule())
                    }
                    .padding(.vertical)
                }
            }
            .padding()
            .background(Color.purple.clipShape(CustomShapeSmothCurves()))
            .padding()
        }
    }
}

struct CustomShapeSmothCurves: Shape {
    func path(in rect: CGRect) -> Path {
        return Path{path in
            let pt1 = CGPoint(x: 0, y: 0)
            let pt2 = CGPoint(x: 0, y: rect.height)
            let pt3 = CGPoint(x: rect.width, y: rect.height)
            let pt4 = CGPoint(x: rect.width, y: 150)
            
            path.move(to: pt4)
            path.addArc(tangent1End: pt1, tangent2End: pt2, radius: 45)
            path.addArc(tangent1End: pt2, tangent2End: pt3, radius: 45)
            path.addArc(tangent1End: pt3, tangent2End: pt4, radius: 45)
            path.addArc(tangent1End: pt4, tangent2End: pt1, radius: 45)
        }
    }
}

//Simple Logic...
// were going to draw triangle...
