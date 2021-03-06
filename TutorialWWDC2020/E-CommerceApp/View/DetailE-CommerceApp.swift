//
//  DetailE-CommerceApp.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 06/12/21.
//

import SwiftUI

struct DetailE_CommerceApp: View {
    
    @Binding var selectedItem: ItemE_Commerce
    @Binding var show: Bool
    
    var animation: Namespace.ID
    
    @State var loadContent = false
    
    @State var selectedColor : Color = Color("Color1")
    
    var body: some View {
        
//        optimisation for smaller size iphone...
        ScrollView(UIScreen.main.bounds.height < 750 ? .vertical : .init()) {
            VStack{
                
                HStack(spacing: 25){
                    
                    Button {
                        
    //                    closing view...
                        withAnimation(.spring()){
                            show.toggle()
                        }
                        
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title)
                            .foregroundColor(.black)
                    }

                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .font(.title)
                            .foregroundColor(.black)
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "bag")
                            .font(.title)
                            .foregroundColor(.black)
                    }

                    
                }
                .padding()
                
                VStack(spacing: 10){
                    Image(selectedItem.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
        //            since id is common.....
                        .matchedGeometryEffect(id: "image\(selectedItem.id)", in: animation)
                        .padding()
                    
                    Text(selectedItem.title)
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    
                    Text(selectedItem.subTitle)
                        .foregroundColor(.gray)
                        .padding(.top,4)
                    
                    HStack{
                        
                        Text(selectedItem.rating)
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                            .matchedGeometryEffect(id: "rating\(selectedItem.id)", in: animation)
                        
                        Spacer()
                        Button {
                             
                        } label: {
                            Image(systemName: "suit.heart")
                                .font(.title2)
                                .foregroundColor(.black)
                        }
                        .matchedGeometryEffect(id: "heart\(selectedItem.id)", in: animation)
                        
                       
                    }
                    .padding()
                }
                .padding(.top,35)
    //            .background(Color(selectedItem.image))
                .background(Color.red
                                .clipShape(CustomShapeE_CommerceApp())
                                .matchedGeometryEffect(id: "color\(selectedItem.id)", in: animation)
                )
                .cornerRadius(15)
                .padding()
                
    //        delay loading the content for smooth animation...
                VStack{
                    VStack(alignment: .leading,spacing: 8){
                        Text("Exclusive Offer")
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                        Text("Frame + Lens for $35(it's 50% off)")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .frame(width: UIScreen.main.bounds.width - 30, alignment: .leading)
                    .background(Color("p3"))
                    .cornerRadius(15)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Color")
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                        
                        HStack(spacing: 15){
                            ForEach(1...4,id:\.self){ i in
                                ZStack{
                                    Color("Color\(i)")
                                        .clipShape(Circle())
                                        .frame(width: 45, height: 45)
                                        .onTapGesture {
                                            withAnimation {
                                                selectedColor = Color("Color\(i)")
                                            }
                                        }
                                    
    //                                checkmark for selected one...
                                    if selectedColor == Color("Color\(i)"){
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                            
                            Spacer(minLength: 0)
                        }
                    }
                    .padding()
                    
                    Spacer(minLength: 15)
                    
                    Button {
                        
                    } label: {
                        Text("TRY FRAME IN 3D")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 100)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.black,lineWidth: 1)
                            )
                    }

                    Button {
                        
                    } label: {
                        Text("ADD TO CART")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 100)
                            .background(Color.black)
                            .cornerRadius(15)
                    }
                    .padding(.vertical)
                }
                .padding([.horizontal,.bottom])
                .frame(height: loadContent ? nil : 0)
                .opacity(loadContent ? 1 : 0)
    //            for smooth transition..
                
                Spacer(minLength: 0)
            }
        }
        .onAppear{
            withAnimation(.spring().delay(0.45)){
                loadContent.toggle()
            }
        }
    }
}

struct DetailE_CommerceApp_Previews: PreviewProvider {
    static var previews: some View {
        E_CommerceAppView()
    }
}
