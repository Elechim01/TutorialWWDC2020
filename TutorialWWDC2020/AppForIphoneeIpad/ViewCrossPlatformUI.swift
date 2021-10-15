//
//  ViewCrossPlatformUI.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 06/10/21.
//

import SwiftUI

struct ViewCrossPlatformUI: View {
    
    @State var index = "Home"
    @State var menu = false
    var device = UIDevice.current.userInterfaceIdiom
    @Environment(\.horizontalSizeClass) var width
    
    var body: some View {
        ZStack {
            VStack{
                navBar(index: $index, menu: $menu)
                
                ZStack{
                    //                    Tab Views...
                    if index == "Home"{
                        ScrollView(.vertical, showsIndicators: false) {
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: getColumns()), spacing: 20) {
                                ForEach(1...9,id: \.self){_ in
                                    CardView()
                                }
                            }
                            .padding(.horizontal)
                            .padding(.vertical,30)
                        }
                    }else if index == "SwiftUI 2.0"{
                        VStack{
                            Color.yellow
                        }
                        .padding(.top,35)
                    }else if index == "SwiftUI"{
                        VStack{
                            Color.blue
                        }
                        .padding(.top,35)
                    }else{
                        VStack{
                            Color.red
                        }
                        .padding(.top,35)
                    }
                }
                .padding(.leading,UIApplication.shared.windows.first?.safeAreaInsets.left)
                .padding(.trailing,UIApplication.shared.windows.first?.safeAreaInsets.right)
            }
            //            Iphone Menù...
            if menu{
                VStack{
                    Spacer()
                    LazyVStack(alignment: .leading,spacing: 25){
                        //                    Nav Buttons...
                        navButton(index: $index, title: "Home")
                            .padding(.leading,25)
                        
                        navButton(index: $index, title: "SwiftUI 2.0")
                            .padding(.leading,25)
                        
                        navButton(index: $index, title: "SwiftUI")
                            .padding(.leading,25)
                        
                        navButton(index: $index, title: "Contact")
                            .padding(.leading,25)
                        
                        //                      Center Button...
                        HStack{
                            Spacer()
                            Button {
                                
                            } label: {
                                Text("Donate")
                                    .foregroundColor(.white)
                                    .padding(.vertical,10)
                                    .padding(.horizontal,25)
                                    .background(Capsule().stroke(Color.white))
                            }
                            Spacer()
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width -
                           (UIApplication.shared.windows.first!.safeAreaInsets.left +
                            UIApplication.shared.windows.first!.safeAreaInsets.right + 50))
                    .padding(.vertical,20)
                    .background(Color("Color4"))
                    .cornerRadius(25)
                    
                    Spacer()
                }
                //                dim background...
                .frame(maxWidth: .infinity,maxHeight: .infinity)
                .background(
                    Color.black.opacity(0.35).edgesIgnoringSafeArea(.all)
                    //                    closing menu when user clicks outside...
                        .onTapGesture {
                            withAnimation {
                                menu.toggle()
                            }
                        }
                )
            }
        }
        .preferredColorScheme(.dark)
        .edgesIgnoringSafeArea(.all)
        .background(Color("Color4"))
//        we need to close menu when menu item is clicked...
        .onChange(of: index) { newValue in
//          if menu is enabled when index value changes close the menu...
            if menu{
                withAnimation {
                    menu.toggle()
                }
            }
        }
    }
    
    func getColumns() -> Int {
//        simple calcuations for ipad and iphone....
//        chacking whether phone is portait or landscape
//        for ipad and mac columns will be 3
//        for iphone when potrait will be 1 and landscape will be 3...
        return (device == .mac || device == .pad) ? 3 : ((device == .phone && width == .regular) ? 3 : 1)
    }
}

struct ViewCrossPlatformUI_Previews: PreviewProvider {
    static var previews: some View {
        ViewCrossPlatformUI()
    }
}
struct CardView : View {
    
    var device = UIDevice.current.userInterfaceIdiom
    @Environment(\.horizontalSizeClass) var width
    
    var body: some View{
        VStack(spacing: 20){
            Image("p1")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Text("Stacking Elements")
                .font(.title)
                .lineLimit(1)
            
            Text("SwiftUI Complex UI Tutorials")
                .lineLimit(2)
        }
//        default frame when iphone in landscape...
        .frame(height: (device == .phone && width == .regular) ? 250 : nil)
        .padding()
        .background(Color.black.opacity(0.5))
        .cornerRadius(20)
    }
}
struct navBar: View  {
    
//    to detect device...
    var device = UIDevice.current.userInterfaceIdiom
    @Environment(\.horizontalSizeClass) var width
//    default is Home...
    @Binding var index : String
//    to toggle menu...
    @Binding var menu : Bool
    
    var body: some View{
        
        HStack{
            Text("Michele")
                .fontWeight(.bold)
                .font(.system(size: device == .phone ? 25 : 35))
            
            Spacer(minLength: 0)
            
            if device == .pad || device == .mac{
                HStack(spacing: 25){
//                    Nav Buttons...
                    navButton(index: $index, title: "Home")
                    
                    navButton(index: $index, title: "SwiftUI 2.0")
                    
                    navButton(index: $index, title: "SwiftUI")
                    
                    navButton(index: $index, title: "Contact")
                    
                    Button {
                        
                    } label: {
                        Text("Donate")
                            .foregroundColor(.white)
                            .padding(.vertical,10)
                            .padding(.horizontal,25)
                            .background(Capsule().stroke(Color.white))
                    }

                }
            }
            else{
//                showing menu button on iphone...
                Button {
//                    toggoling menu...
                    withAnimation {
                        menu.toggle()
                    }
                } label: {
                    Image(systemName: "line.horizontal.3")
                        .font(.system(size: 26))
                        .foregroundColor(.white)
                }

            }
        }
        .padding(.top,(device == .phone && width == .regular) ? 0 : UIApplication.shared.windows.first?.safeAreaInsets.top)
        .padding()
        .background(Color("Color4"))
//        shadow...
        .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}
struct navButton: View {
    
    @Binding var index : String
    var title : String
    var body: some View{
        Button {
            withAnimation {
                index = title
            }
        } label: {
            Text(title)
                .fontWeight(index == title ? .bold : .none)
                .foregroundColor(index == title ? .white : Color.white.opacity(0.7))
        }

    }
}
