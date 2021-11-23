//
//  ViewCustomActionSheetsWithCheckBoxes.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 23/11/21.
//

import SwiftUI
import MapKit

struct ViewCustomActionSheetsWithCheckBoxes: View {
    var body: some View {
        
        HomeViewCustomActionSheetsWithCheckBoxes()
    }
}

struct ViewCustomActionSheetsWithCheckBoxes_Previews: PreviewProvider {
    static var previews: some View {
        ViewCustomActionSheetsWithCheckBoxes()
    }
}

struct HomeViewCustomActionSheetsWithCheckBoxes: View {
    
    @State var coordinate = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.335, longitude: -122.0132),latitudinalMeters: 10000,longitudinalMeters: 10000)
    
    @State var filters = [
        FilterItemCustomActionSheetsWithCheckBoxes(title: "prova1", checked: false),
        FilterItemCustomActionSheetsWithCheckBoxes(title: "prova2", checked: false),
        FilterItemCustomActionSheetsWithCheckBoxes(title: "prova3", checked: false),
        FilterItemCustomActionSheetsWithCheckBoxes(title: "prova4", checked: false),
        FilterItemCustomActionSheetsWithCheckBoxes(title: "prova5", checked: false),
    ]
    
    @State var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @State var showFilter = false
    
    var body: some View{
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
            Map(coordinateRegion: $coordinate)
                .ignoresSafeArea()
            
//            filter Button....
            
            Button {
                withAnimation {
                    showFilter.toggle()
                }
            } label: {
                Image(systemName: "slider.vertical.3")
                    .font(.title2)
                    .foregroundColor(.black)
                    .padding(.vertical,10)
                    .padding(.horizontal,15)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: -5, y: -5)

            }
            .padding(.trailing)
            .padding(.top,10)
            
//    Filter or Radio Button View...
            VStack{
                Spacer()
                
                VStack(spacing: 18){
                    HStack{
                        Text("Search By")
                            .font(.title2)
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                showFilter.toggle()
                            }
                        } label: {
                            Text("Done")
                                .fontWeight(.heavy)
                                .foregroundColor(Color.green)
                        }
                    }
                    .padding([.horizontal,.top])
                    .padding(.bottom,10)
                    
                    ForEach(filters){ filter in
                        
                        CardViewCustomActionSheetsWithCheckBoxes(filter: filter)
                    }
                }
                .padding(.bottom,10)
                .padding(.bottom,edges?.bottom)
                .padding(.top,10)
                .background(Color.white.clipShape(CustomCornerCustomActionSheetsWithCheckBoxes(corners: [.topLeft,.topRight])))
                .offset(y: showFilter ? 0 : UIScreen.main.bounds.height / 2)
            }
            .ignoresSafeArea()
            .background(
                Color.black.opacity(0.3).ignoresSafeArea()
                    .opacity(showFilter ? 1 : 0)
//                add close
                    .onTapGesture {
                        withAnimation{showFilter.toggle()}
                    }
            )
        }
    }
}

struct CustomCornerCustomActionSheetsWithCheckBoxes: Shape {
    
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: 35, height: 35))
        
        return Path(path.cgPath)
    }
}

// cardView...
struct CardViewCustomActionSheetsWithCheckBoxes: View {
    @State var filter: FilterItemCustomActionSheetsWithCheckBoxes
    
    var body: some View{
        HStack{
            Text(filter.title)
                .fontWeight(.semibold)
                .foregroundColor(Color.black.opacity(0.7))
            
            Spacer()
            
            ZStack{
                Circle()
                    .stroke(filter.checked ? Color.green :  Color.gray,lineWidth: 1)
                    .frame(width: 25, height: 25)
                
                if filter.checked{
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 25))
                        .foregroundColor(Color.green)
                }
            }
        }
        .padding(.horizontal)
        .contentShape(Rectangle())
        .onTapGesture {
            filter.checked.toggle()
        }
    }
}

// sample Filters..

struct FilterItemCustomActionSheetsWithCheckBoxes: Identifiable {
    var id = UUID().uuidString
    var title: String
    var checked: Bool
}

