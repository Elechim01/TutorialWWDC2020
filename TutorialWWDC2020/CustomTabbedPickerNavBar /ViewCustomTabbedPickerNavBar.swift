//
//  ViewCustomTabbedPickerNavBar .swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 22/11/21.
//

import SwiftUI

struct ViewCustomTabbedPickerNavBar: View {
    var body: some View {
        HomeViewCustomTabbedPickerNavBar()
    }
}

struct ViewCustomTabbedPickerNavBar_Previews: PreviewProvider {
    static var previews: some View {
        ViewCustomTabbedPickerNavBar()
    }
}

struct HomeViewCustomTabbedPickerNavBar: View {
    
//    top edge value...
    @State var top = UIApplication.shared.windows.first?.safeAreaInsets.top
    @State var current = "house.fill"
    @Namespace var animation
    @State var isHide = false
    
    var body: some View{
        VStack(spacing: 0){
            
//            App Bar...
            VStack(spacing: 22){
                
                if !isHide{
                    HStack(spacing: 12){
                        Text("facebook")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(Color.blue)
                        
                        Spacer(minLength: 0)
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.black)
                                .padding(10)
                                .background(Color.black.opacity(0.1))
                                .clipShape(Circle())
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "message.fill")
                                .foregroundColor(.black)
                                .padding(10)
                                .background(Color.black.opacity(0.1))
                                .clipShape(Circle())
                        }
                        
                    }
                    .padding(.horizontal)
                }
                
//                Custom Tab Bar...
                HStack(spacing: 0){
                    TabBarButtonCustomTabbedPickerNavBar(current: $current, image: "house.fill", animation: animation)
                    TabBarButtonCustomTabbedPickerNavBar(current: $current, image: "magnifyi ngglass", animation: animation)
                    TabBarButtonCustomTabbedPickerNavBar(current: $current, image: "person.2.fill", animation: animation)
                    TabBarButtonCustomTabbedPickerNavBar(current: $current, image: "tv.fill", animation: animation)
                }
                
            }
            .padding(.top,top! + 10 )
            .background(Color.white)
            
//           Content...
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(spacing: 0){
                    
//                    geometry reader for getting location values..
                    GeometryReader{ reader -> AnyView in
                        
                        let yAxis = reader.frame(in: .global).minY
                        
//                    logic simple if if goes below zero hide nav bar
//                    above zero navbar...
                        
                        if yAxis < 0 && !isHide{
                            DispatchQueue.main.async {
                                withAnimation {
                                    isHide = true
                                }
                            }
                        }
                        
                        if yAxis > 0 && isHide{
                            DispatchQueue.main.async {
                                withAnimation {
                                    isHide = false
                                }
                            }
                        }
                        
                        return AnyView(
                            Text("")
                                .frame(width: 0, height: 0)
                        )
                    }
                    .frame(width: 0, height: 0)
                    
                    VStack(spacing:15){
                        
                        ForEach(1...20,id:\.self) { i in
                            
                            VStack(spacing: 10){
                                
                                HStack(spacing: 10){
                                    Image("logo")
                                        .resizable()
                                        .frame(width: 35, height: 35)
                                        .clipShape(Circle())
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        
                                        Text("Michele")
                                            .font(.title2)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.black)
                                        Text("\(45 - i)   Min")
                                    }
                                    
                                    Spacer(minLength: 0)
                                }
                                
                                Text("prova 1 ciao bello come va? ")
                                
                            }
                            .padding()
                            .background(Color.white)
                        }
                    }
                }
                .padding(.top)
            }
        }
        .background(Color.black.opacity(0.07))
        .ignoresSafeArea()
    }
}

struct TabBarButtonCustomTabbedPickerNavBar: View {
    
    @Binding var current: String
    var image: String
    var animation: Namespace.ID
    
    var body: some View{
        Button {
            withAnimation {
                current = image
            }
        } label: {
            VStack(spacing: 5){
                Image(systemName: image)
                    .font(.title2)
                    .foregroundColor(current == image ? Color.blue : Color.black.opacity(0.3))
//                default Frame to avoid resizing...
                    .frame(height: 35)
                
                ZStack{
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 4)
                    
//                    matched geometry effect slide animation...
                    if current == image{
                        Rectangle()
                            .fill(Color.blue)
                            .frame(height: 4)
                            .matchedGeometryEffect(id: "Tab", in: animation)
                    }
                }
            }
        }

    }
}
