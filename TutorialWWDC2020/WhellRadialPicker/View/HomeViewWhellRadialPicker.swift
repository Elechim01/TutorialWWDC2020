//
//  HomeViewWhellRadialPicker.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 03/11/21.
//

import SwiftUI

struct HomeViewWhellRadialPicker: View {
    
    @State var circleWidth = UIScreen.main.bounds.width / 1.5
    @State var height = UIScreen.main.bounds.height
    @StateObject var homeData = HomeViewModelWheelRadialPicker()
    
    var body: some View {
        ZStack{
           Image("g1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width)
            
            VStack{
                Spacer(minLength: 0)
                
                VStack{
                    HStack{
                        
                        OptionViewWhellRadialPicker(image: "lock.rotation")
                        
                        Spacer(minLength: 0)
                        
                        OptionViewWhellRadialPicker(image: "bolt.fill")
                        
                        Spacer(minLength: 0)
                        
                        OptionViewWhellRadialPicker(image: "line.horizontal.3")
                    }
                    .padding()
                    
                    HStack{
                        Button {
                            
                        } label: {
                            Image("g1")
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 65, height: 65)
                                .clipShape(Circle())
                        }
                        
                        Spacer(minLength: 0)
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "video.fill")
                                .font(.title2)
                                .foregroundColor(.black)
                                .frame(width: 65, height: 65)
                                .background(Color.white)
                                .clipShape(Circle())
                        }


                    }
                    .padding(.horizontal)
                    .padding(.top)
                }
//                Since bottom edge is ignored...
                .padding(.bottom,UIApplication.shared.windows.first!.safeAreaInsets.bottom == 0 ? 15 : UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                .background(Color.black.opacity(0.65))
//                background dim effect...
                .overlay(Color.black.opacity(homeData.show ? 0.7 : 0))
            }
            
//            Wheel Picker...
            ZStack{
                Circle()
//                Top Cut....
                    .trim(from: 0.5, to: 1)
                    .stroke(Color.white, lineWidth: 65)
                    .frame(width: circleWidth, height: circleWidth)
                    .opacity(homeData.show ? 1 : 0)
                
//                Camera...
                
                Image(systemName: "camera.fill")
                    .font(.title2)
                    .foregroundColor(.black)
                    .frame(width: 65, height: 65)
                    .background(Color.white)
                    .clipShape(Circle())
//                Animation...
                    .offset(y:homeData.show ? 0 : -60)
                    .opacity(homeData.show ? 0 : 1)
//                adding Gesture...
                    .gesture(DragGesture(minimumDistance: 0).onChanged(homeData.onChanged(value:)).onEnded(homeData.onEnded(value:)))
//                bottom edge Padding...
                    .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                
//                adding Function Buttons...
                ZStack{
                    FunctionButtonWheelRadialPicker(image: "face.dashed", angle: 20,current: $homeData.current,index: 1)
                    FunctionButtonWheelRadialPicker(image: "timer", angle: 50,current: $homeData.current,index: 2)
                    FunctionButtonWheelRadialPicker(image: "pano", angle: 90,current: $homeData.current,index: 3)
                    FunctionButtonWheelRadialPicker(image: "light.max", angle: 130,current: $homeData.current,index: 4)
                    FunctionButtonWheelRadialPicker(image: "gearshape.fill", angle: 160,current: $homeData.current,index: 5)
                }
//                Moving All View To Left...
//                So Angle Will Be Perfect
                .opacity(homeData.show ? 1 : 0)
            }
//            Moving View To Bottom....
            .offset(y: (height / 2) + 10)
            
            if homeData.getName() != "" && homeData.popup{
                Text(homeData.getName())
                    .foregroundColor(.white)
                    .padding(.vertical,6)
                    .padding(.horizontal,15)
                    .background(Color.black)
                    .cornerRadius(6)
            }
        }
        .ignoresSafeArea(.all,edges: .all)
    }
}

