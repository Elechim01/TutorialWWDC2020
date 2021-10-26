//
//  ViewNikeShowUI.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 26/10/21.
//

import SwiftUI

struct ViewNikeShowUI: View {
    
    var black = Color.black.opacity(0.7)
    var width = UIScreen.main.bounds.width
    @State var more = false
    @State var gender = "Male"
    @State var size = 6
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @State var added = false
    
    var body: some View {
        VStack{
            ZStack{
                HStack{
                    Button {
                        
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 22))
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                            .background(Color("CNS2"))
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
                    }
                    
                    Spacer(minLength: 0)
                    Button {
                        
                    } label: {
                        Image(systemName: "suit.heart")
                            .font(.system(size: 22))
                            .foregroundColor(black)
                            .frame(width: 40, height: 40)
                            .background(Color("CNS1"))
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
                    }
                }
                Image("nike")
                    .resizable()
                    .frame(width: 55, height: 55)
            }
            .padding()
            
            Image("shoe")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width - (more ? 200 : 100))
                .padding(.top,25)
            
                ScrollView(UIScreen.main.bounds.height < 750 ? .vertical : .init(), showsIndicators: false) {
                    VStack{
                        HStack{
                                Text("Nikie Air Huararche For Women")
                                .font(.title2)
                                .fontWeight(.heavy)
                                .foregroundColor(.black)
                            
                            Spacer(minLength: 0)
                            
                            Text("$168")
                            .font(.title2)
                            .fontWeight(.heavy)
                            .foregroundColor(Color("CNS2"))
                        }
                        .padding(.top,25)
                        .padding(.trailing)
                        
                        VStack(alignment: .leading, spacing: 5){
                            Text("ndsjcnsdkjcnsdcdjiojirejfedcndscndsnckjsdcnkjsdnckjsdncjajjnjdajdnjsdabjdughurhfapuihfppa")
                                .lineLimit(more ? nil : 3)
                                .foregroundColor(black)
                            
                            Button {
                                withAnimation {
                                    more.toggle()
                                }
                            } label: {
                                Text("Read More")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("CNS2"))
                            }
                        }
                        .padding([.vertical,.trailing])
                        
                        
                        HStack(spacing: 15){
                            Text("Gender")
                                .fontWeight(.heavy)
                                .foregroundColor(black)
                                .frame(width: 75,alignment: .leading)
                            
                            GenderButton(gender: $gender, title: "Male")
                            
                            GenderButton(gender: $gender, title: "Female")
                            
                            Spacer(minLength: 0)
                        }
                        .padding(.trailing)
                        .padding(.top,10)

                        HStack(spacing: 15){
                            Text("Size")
                                .fontWeight(.heavy)
                                .foregroundColor(black)
                                .frame(width: 75,alignment: .leading)
                            
                            ForEach(sizes,id : \.self){ title in
                                SizeButton(size: $size, title: title)
                            }
                            
                            Spacer(minLength: 0)
                        }
                        .padding(.trailing)
                        .padding(.top,10)
                        
                        Spacer(minLength: 0)
                        
                        Button {
                            added.toggle()
                        } label: {
                            Label {
                                Text(added ? "Added" : "Add To Bag")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .fontWeight(.heavy)
                            } icon: {
                                Image(systemName: added ? "checkmark.circle.fill" : "cart.fill")
                                    .font(.system(size: 22))
                                    .foregroundColor(.white)
                            }
                            .padding(.vertical,12)
    //                        Padding 30 + 45  = 75
                            .frame(width: width - 75)
                            .background(added ? Color.green :  Color("CNS2"))
                            .clipShape(Capsule())
                            .padding(.leading,-45)
                            .padding(.top)
                            .padding(.bottom)
    //                        .padding(.bottom,edges!.bottom == 0 ? 15 : edges!.bottom)

                        }

                    }
                    .padding(.leading,45)
                }
                .background(Color("CNS1"))
                .shadow(radius: 0)
                .clipShape(CustomShapeNikeShow())
                .padding(.top,30)
                .shadow(color: Color.black.opacity(0.12), radius: 5, x: -5, y: -10)
        }
        .background(Color("CNS1").ignoresSafeArea(.all,edges: .all))
        .ignoresSafeArea(.all,edges: .bottom)
    }
}

struct ViewNikeShowUI_Previews: PreviewProvider {
    static var previews: some View {
        ViewNikeShowUI()
    }
}

struct CustomShapeNikeShow: Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft], cornerRadii: CGSize(width: 85, height: 85))
        return Path(path.cgPath)
    }
}
struct GenderButton: View {
    
    @Binding var gender : String
    var title : String
    var black = Color.black.opacity(0.7)
    
    var body: some View{
        Button {
             gender = title
        } label: {
            Text(title)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(gender == title ? .white : black)
                .padding(.vertical,10)
                .frame(width: 80)
                .background(gender == title ?Color("CNS2") : Color.white )
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
        }

    }
}

struct SizeButton: View {
    
    @Binding var size : Int
    var title : Int
    var black = Color.black.opacity(0.7)
    
    var body: some View{
        Button {
             size = title
        } label: {
            Text("\(title)")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(size == title ? .white : black)
                .frame(width: 35,height: 35)
                .background(size == title ?Color("CNS2") : Color.white )
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
        }

    }
}

var sizes = [6,7,8,9,10]
