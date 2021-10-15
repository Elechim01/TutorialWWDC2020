//
//  StylishDashboardAppUIView.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 12/10/21.
//

import SwiftUI

struct StylishDashboardAppUIView: View {
    
    @State var tab = "USA"
    @Namespace var animation
    @State var subTab = "Today"
    @State var dailySaled = [
        
        //    Last 7 Days..
            DailySales(day: Calendar.current.date(byAdding: .day, value: -6, to: Date())!, value: 200, show: true),
            DailySales(day: Calendar.current.date(byAdding: .day, value: -5, to: Date())!, value: 443, show: false),
            DailySales(day: Calendar.current.date(byAdding: .day, value: -4, to: Date())!, value: 616, show: false),
            DailySales(day: Calendar.current.date(byAdding: .day, value: -3, to: Date())!, value: 512, show: false),
            DailySales(day: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, value: 613, show: false),
            DailySales(day: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, value: 300, show: false),
            DailySales(day: Date(), value: 669, show: false)
        ]
    @State var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Button {
                        
                    } label: {
                        Image("menu")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.white)
                            .frame(width: 30, height: 30)
                        
                    }
                    
                    Spacer(minLength: 0)
                    
                    Button {
                        
                    } label: {
                        Image("noti")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.white)
                            .frame(width: 30, height: 30)
                        
                    }
                }
                .padding()
                
                HStack{
                    Text("Dashboard")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Spacer(minLength: 0)
                }
                .padding()
                
                HStack(spacing: 0) {
                    TabButton(selected: $tab, title: "USA", animation: animation)
                    
                    TabButton(selected: $tab, title: "Global", animation: animation)
                }
                .background(Color.white.opacity(0.08))
                .clipShape(Capsule())
                .padding(.horizontal)
                HStack(spacing: 20){
                    ForEach(subTabs,id: \.self){ tab in
                        Button {
                            subTab = tab
                        } label: {
                            Text(tab)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white.opacity(subTab == tab ? 1  : 0.4))
                        }
                        
                    }
                }
                .padding()
                
                //                Or You can use Foreach Also..
                VStack(spacing: 20){
                    HStack(spacing: 15){
                        SalesView(sale: salesData[0])
                        SalesView(sale: salesData[1])
                    }
                    HStack(spacing: 15){
                        SalesView(sale: salesData[2])
                        SalesView(sale: salesData[3])
                        SalesView(sale: salesData[4])
                    }
                }
                .padding(.horizontal)
                
                
                ZStack{
                    Color.white
                        .clipShape(CustomCorners(corners: [.topLeft,.topRight], size: 45))
                        .ignoresSafeArea(.all,edges: .bottom)
                    
                    VStack{
                        
                        HStack{
                            Text("Dail Sold Units")
                                .font(.title2)
                                .foregroundColor(.black)
                            
                            Spacer(minLength: 0)
                        }
                        .padding()
                        .padding(.top,10)
                        
                        HStack(spacing: 10){
                            ForEach(dailySaled.indices,id: \.self){ i in
//                                For Toggling Show Button...
                                GrapthViewStylish(data: dailySaled[i], allData: dailySaled)
                                    .onTapGesture {
                                        withAnimation {
                                            
//                                          toggling all other...
                                            for index in 0..<dailySaled.count{
                                                dailySaled[index].show = false
                                            }
                                            dailySaled[i].show.toggle()
                                        }
                                    }
//                                sample Sapcing For Spacing Effect...
                                if dailySaled[i].value != dailySaled.last!.value{
                                    Spacer(minLength: 0)
                                }
                            }
                        }
                        .padding(.horizontal,30)
                        .padding(.bottom,edges?.bottom == 0 ? 15 : 0)
                    }
                }
                .padding(.top,20)
            }
            .background(Color("bg").ignoresSafeArea(.all, edges: .all))
            .preferredColorScheme(.dark)
            .navigationTitle("")
            .navigationBarHidden(true)
        }
       
    }
}

var subTabs = ["Today","Yesterday","Last Week"]


struct StylishDashboardAppUIView_Previews: PreviewProvider {
    static var previews: some View {
        StylishDashboardAppUIView()
    }
}

struct TabButton : View {
    
    @Binding var selected : String
    var title : String
    var animation : Namespace.ID
    
    var body: some View{
        Button {
            withAnimation(.spring()) {
                selected = title
            }
        } label: {
            ZStack{
//                Capsule and Sliding Effect...
                
                Capsule()
                    .fill(Color.clear)
                    .frame(height: 45)
                
                if selected == title{
                    Capsule()
                        .fill(Color.white)
                        .frame(height: 45)
//                    Matched Geomtery Effect...
                        .matchedGeometryEffect(id: "Tab", in: animation)
                }
                
                Text(title)
                    .foregroundColor(selected == title ? .black : .white)
                    .fontWeight(.bold)
            }
        }

    }
}

// Sample Model Data...
struct Sales : Identifiable {
    
    var id = UUID().uuidString
    var title : String
    var value : String
    var color : Color
}
var salesData = [
    Sales(title: "Sold", value: "18,789", color: .orange),
    Sales(title: "Returned", value: "1,089", color: .red),
    Sales(title: "Delivered", value: "8,500", color: .blue),
    Sales(title: "Transit", value: "2,000", color: .pink),
    Sales(title: "Cancelled", value: "1,700", color: .purple)
    
]

// Daily Solid Model And Data...

struct DailySales: Identifiable {
    var id = UUID().uuidString
    var day : Date
    var value : CGFloat
    var show : Bool
}



struct SalesView : View {
   
    var sale : Sales
    
    var body: some View{
        
        ZStack{
            HStack{
                VStack(alignment: .leading, spacing: 22) {
                    Text(sale.title)
                        .foregroundColor(.white)
                    
                    Text(sale.value)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                Spacer(minLength: 0)
            }
            .padding()
        }
        .background(sale.color)
        .cornerRadius(10)
    }
}

//Custom Corners...
struct CustomCorners: Shape {
    
    var corners : UIRectCorner
    var size : CGFloat
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: size, height: size))
        
        return Path(path.cgPath)
    }
}

struct GrapthViewStylish : View {
    
    var data : DailySales
    var allData : [DailySales]
    
    var body: some View{
        VStack(spacing: 5){
            
            GeometryReader{ reader in
                VStack(spacing: 0){
                    
                    Spacer(minLength: 0)
                    
                    Text("\(Int(data.value))")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
//                    default height For Graph...
                        .frame(height: 20)
                        .opacity(data.show ? 1 : 0)
//
                    
                    RoundedRectangle(cornerRadius:  5)
                        .fill(Color.red.opacity(data.show ? 1: 0.4))
                        .frame(height: calculateHeight(value: data.value, height: reader.frame(in: .global).height))
                       
                     
                    
                }
            }
            
            Text(customDateStyle(date:data.day))
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
    
    func customDateStyle(date: Date) -> String {
        let formatt = DateFormatter()
        formatt.dateFormat = "MMM dd"
        return formatt.string(from: date)
    }
    
    func calculateHeight(value : CGFloat,height: CGFloat) -> CGFloat{
        let max = allData.max { (max, sale) -> Bool in
            if max.value > sale.value{return false}
            else{return true}
        }
        
        let percent = value / max!.value
        
        print(percent * height)
        return percent * height
    }
    
}
