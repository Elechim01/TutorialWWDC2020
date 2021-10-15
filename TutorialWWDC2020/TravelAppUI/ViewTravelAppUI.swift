//
//  ViewTravelAppUI.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 07/10/21.
//

import SwiftUI

struct ViewTravelAppUI: View {
    var body: some View {
        MainView()
    }
}

struct ViewTravelAppUI_Previews: PreviewProvider {
    static var previews: some View {
        ViewTravelAppUI()
    }
}

struct HomeTavel: View {
    
    var animation : Namespace.ID
    @Binding var show : Bool
    @Binding var selected : ModelTravel
    
    var body: some View{
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack{
                
                HStack{
                    Text("Discover a \nDifferent World")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .foregroundColor(Color("Color4"))
                    
                    Spacer(minLength: 0)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .renderingMode(.template)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color("Color1"))
                            .clipShape(Circle())
                    }
                    
                }
                .padding()
                //            since all edges are ignored....
                .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15){
                        ForEach(1...5,id: \.self){ i in
                            Image("g\(i)")
                                .resizable()
                                .renderingMode(.original)
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                                .onTapGesture {
                                    //                                do some stuff...
                                }
                        }
                    }
                    .padding()
                }
                
                HStack{
                    Text("Destinations")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color("Color4"))
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Text("See All")
                            .foregroundColor(.gray)
                    }
                    
                }
                .padding()
                
                ForEach(dataTravel){ travel in
                    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                        Image("\(travel.img)")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 300)
                            .cornerRadius(25)
                            .matchedGeometryEffect(id: travel.img, in: animation)
                        
                        VStack(alignment: .trailing, spacing: 8) {
                            Text(travel.title)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .matchedGeometryEffect(id: travel.title, in: animation)
                            
                            Text(travel.country)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .matchedGeometryEffect(id: travel.country, in: animation)
                        }
                        .padding()
                    }
                    .onTapGesture {
                        withAnimation(.spring()){
                            selected = travel
                            show.toggle()
                        }
                    }
                }
                .padding()
//                setting detail Data...
               
            
            }
        }
    }
}

struct LikeTavel: View {
    var body: some View{
        VStack{
            Spacer()
            
            Text("Like")
            
            Spacer()
        }
    }
}

struct AccountTavel: View {
    var body: some View{
        VStack{
            Spacer()
            
            Text("Account")
            
            Spacer()
        }
    }
}

//Creating Tab views...
struct MainView: View {
    
    @State var tab = "Explore"
    @Namespace var animation
    @State var show = false
    @State var selected : ModelTravel = dataTravel[0]
    
    var body: some View{
        
        ZStack{
            VStack(spacing: 0){
            
//            changing Views Based On tab...
            switch(tab){
            case "Explore" : HomeTavel(animation: animation, show: $show, selected: $selected)
            case "Liked" : LikeTavel()
            default : AccountTavel()
            }
            
            Spacer()
            
            HStack(spacing: 0){
                
                tabButton(title: "Explore", tab: $tab)
                
                Spacer(minLength: 0)
                
                tabButton(title: "Liked", tab: $tab)
                
                Spacer(minLength: 0)
                
                tabButton(title: "Account", tab: $tab)
                
            }
            .padding(.top)
//            for smaller size iPhones...
//            .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 15 : UIApplication.shared.windows.first!.safeAreaInsets.bottom)
            .padding(.bottom)
            .padding(.horizontal,35)
            .background(Color.white)
            .clipShape(RoundedShapeTravelV(corners: [.topLeft,.topRight]))
        
        }
            
//            Detail View...
            if show{
                DetailTravel(selected: $selected, show: $show, animation: animation)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .background(Color("Color").edgesIgnoringSafeArea(.all))
    }
}

//Detail View....
struct DetailTravel : View {
    
    @Binding var selected: ModelTravel
    @Binding var show : Bool
    var animation : Namespace.ID
    
    var body: some View{
        VStack{
            VStack {
                ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
                    Image(selected.img)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width,height: 330)
                        .clipShape(RoundedShapeTravelV(corners: [.bottomLeft,.bottomRight]))
                    .matchedGeometryEffect(id: selected.img, in: animation)
                    
                    HStack{
                        Button {
                            withAnimation(.spring()) {
                                show.toggle()
                            }
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                        }
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "suit.heart")
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                        }
                        
                    }
                    .padding()
//                    since all edges are ingored...
                    .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                }
//                Detail View...
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text(selected.title)
                            .font(.title)
                            .foregroundColor(Color("Color4"))
                            .fontWeight(.bold)
                            .matchedGeometryEffect(id: selected.title, in: animation)
                            
                        HStack(spacing: 10){
                            Image(systemName: "map")
                            
                            Text(selected.country)
                                .foregroundColor(.black)
                                .matchedGeometryEffect(id: selected.country, in: animation)
                            
                            HStack(spacing: 5){
                                
                                Text(selected.ratings)
                                    .foregroundColor(.black)
                                
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            }
                        }
                    }
                    
                    Spacer(minLength: 0)
                    
                    Text(selected.price)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color("Color4"))
                }
                .padding()
                .padding(.bottom)
            }
            .background(Color.white)
            .clipShape(RoundedShapeTravelV(corners: [.bottomLeft,.bottomRight]))
               
//            ScrollView for Smaller Size Phones...
            if UIScreen.main.bounds.height < 750{
                ScrollView(.vertical, showsIndicators: false) {
                    BottomViewTravel()
                }
            }else{
                BottomViewTravel()
            }
            
            Spacer(minLength: 0)
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(Color("Color"))
    }
}

struct BottomViewTravel : View {
    
    @State var index = 1
    var body: some View{
        VStack(alignment: .leading, spacing: 15) {
            Text("People")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color("Color4"))
            
            Text("Member Of Your Group")
                .font(.caption)
            
            HStack(spacing: 15){
                ForEach(1...6,id: \.self){ i in
                    Button {
                        index = i
                    } label: {
                        Text("\(i)")
                            .fontWeight(.bold)
                            .foregroundColor(index == i ? .white : .gray)
                            .padding(.vertical,10)
                            .padding(.horizontal)
                            .background(Color("Color1").opacity(index == i ? 1 : 0.07))
                            .cornerRadius(4)
                    }
                }
                Spacer(minLength: 0)
            }
            .padding(.top)
            
            Text("Description")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color("Color4"))
                .padding(.top,10)
            
            Text("iociojweifjweiosdcmlkmewofjioejfuierhghierughierj")
                .multilineTextAlignment(.leading)
            
            Spacer(minLength: 0)
            HStack{
                Spacer()
                Button {
                    
                } label: {
                    Text("Book Now")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 100)
                        .background(Color("Color1"))
                        .clipShape(Capsule())
                }
                Spacer()
            }
            .padding(.top)
//            since all edge are ignored...
            .padding(.bottom,UIApplication.shared.windows.first!.safeAreaInsets.bottom == 0 ? 15 : UIApplication.shared.windows.first!.safeAreaInsets.bottom)

        }
        .padding([.horizontal,.top])
    }
}

// Tab Buttons...
struct tabButton : View {
    
    var title : String
    @Binding var tab : String
    
    var body: some View{
        Button {
            tab = title
        } label: {
            
            HStack(spacing: 8) {
                Image(title)
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(tab == title ? .white : .gray)
                 
                
                Text(tab == title ? title : "")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
            }
            .padding(.vertical,10)
            .padding(.horizontal)
            .background(Color("Color1").opacity(tab == title ? 1 : 0))
            .clipShape(Capsule())
        }

    }
}

//bottom only corners...
struct RoundedShapeTravelV : Shape {
    
//    for resuble...
    var corners : UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: 45, height: 45))
        return Path(path.cgPath)
    }
}

//Model And Sample Data...

struct ModelTravel : Identifiable {
    var id = UUID().uuidString
    var title : String
    var country : String
    var ratings : String
    var price : String
    var img : String
}
var dataTravel = [
    ModelTravel(title: "prova1", country: "italia", ratings: "8", price: "30€", img: "p1"),
    ModelTravel(title: "prova2", country: "italia", ratings: "8", price: "30€", img: "p2")
]
