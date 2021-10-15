//
//  HomeFitnessDashboardBarCharts.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 16/09/21.
//

import SwiftUI

struct HomeFitnessDashboardBarCharts: View {
    
    @State var selected = 0
    var colors = [Color("Color1"),Color("Color")]
    var columns = Array(repeating: GridItem(.flexible(),spacing: 20), count: 2)
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack{
                HStack{
                    Text("Hello Emma")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        
                    }, label: {
                        Image("menu")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                    })
                }
                .padding()
                
//                bar Chart...
                VStack(alignment: .leading, spacing: 25, content: {
                    Text("Daily workout in Hrs")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    HStack(spacing: 15){
                        ForEach(workout_Data){ work in
//                            Bars...
                            VStack{
                                VStack{
                                    
                                    Spacer(minLength: 0)
                                    if selected == work.id{
                                        Text(getHrs(value: work.workout_In_Min))
                                            .foregroundColor(Color("Color"))
                                            .padding(.bottom,5)
                                    }
                                    RoundShape()
                                        .fill(LinearGradient(gradient: .init(colors: selected == work.id ? colors : [Color.white.opacity(0.06)]), startPoint: .top, endPoint: .bottom))
                                        //                                max height = 200
                                        .frame(height: getHeight(value: work.workout_In_Min))
                                }
                                .frame(height: 220)
                                .onTapGesture {
                                    withAnimation(.easeOut){
                                        selected = work.id
                                    }
                                }
                                
                                
                                Text(work.day)
                                    .font(.caption)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                })
                .padding()
                .background(Color.white.opacity(0.06))
                .cornerRadius(10)
                .padding()
                
                HStack{
                    Text("Statics")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        
                    }, label: {
                        Image("menu")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                    })
                }
                .padding()
                
//              stats Grid...
                LazyVGrid(columns: columns,spacing: 30, content: {
                    ForEach(stats_Data){ stat in
                        VStack(spacing: 32){
                            HStack{
                                Text(stat.title)
                                    .font(.system(size: 22))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                
                                Spacer(minLength: 0)
                            }
//                            Ring
                            ZStack{
                                Circle()
                                    .trim(from: 0, to: 1)
                                    .stroke(stat.color.opacity(0.05), lineWidth: 10)
                                    .frame(width: (UIScreen.main.bounds.width - 150) / 2, height: (UIScreen.main.bounds.width - 150) / 2 )
                                Circle()
                                    .trim(from: 0, to: (stat.currentData / stat.goal))
                                    .stroke(stat.color, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                                    .frame(width: (UIScreen.main.bounds.width - 150) / 2, height: (UIScreen.main.bounds.width - 150) / 2)
                                Text(getPercent(current: stat.currentData, Goal: stat.goal) + "%")
                                    .font(.system(size: 22))
                                    .fontWeight(.bold)
                                    .foregroundColor(stat.color)
                                    .rotationEffect(.init(degrees: 90))
                            }
                            .rotationEffect(.init(degrees: -90))
                            Text(getDec(val: stat.currentData) + " " + getType(val: stat.title))
                                .font(.system(size: 22))
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                        }
                        .padding()
                        .background(Color.white.opacity(0.06))
                        .cornerRadius(15)
                        .shadow(color: Color.white.opacity(0.2), radius: 10, x: 0, y: 0)
                    }
                })
                .padding()
                
            }
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .preferredColorScheme(.dark)
//        status bar clor is not changing...
//        its still in beta...
    }
    
//    calculating Type....
    func getType(val : String) -> String {
        switch val {
        case "water": return "L"
        case "Sleep": return "Hrs"
        case "Runnig": return "Km"
        case "Cycling" : return "Km"
        case "Steps": return "stp"
        default: return "Kcal "
        }
    }
    
//    converting Number to decimal...
    func getDec(val : CGFloat) -> String {
        let format = NumberFormatter()
        format.numberStyle = .decimal
        return format.string(from: NSNumber.init(value: Float(val)))!
    }
    
    
//    calculatng percent...
    func getPercent(current: CGFloat,Goal: CGFloat) -> String {
        let per = (current / Goal) * 100
        return String(format: "%.1f", per)
    }
    
    
//    calculatng Hrs For Height...
    func getHeight(value : CGFloat) -> CGFloat {
//        the value in minutes....
        
//        getting height...
//        24 hrs in min = 1440
        
        let hrs = CGFloat(value / 1440) * 200
        return hrs
    }
//    getting hrs...
    func getHrs(value: CGFloat) -> String {
        
        let hrs = value / 60
        
        return String(format: "%1.f", hrs)
    }
    
    
}

struct HomeFitnessDashboardBarCharts_Previews: PreviewProvider {
    static var previews: some View {
        HomeFitnessDashboardBarCharts()
    }
}

struct RoundedShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 5, height: 5))
        return Path(path.cgPath)
    }
}

//sample Data...
struct Daily : Identifiable {
    var id: Int
    var day : String
    var workout_In_Min : CGFloat
}
var workout_Data = [
    Daily(id: 0, day: "Day1", workout_In_Min: 480),
    Daily(id: 1, day: "Day2", workout_In_Min: 880),
    Daily(id: 2, day: "Day3", workout_In_Min: 250),
    Daily(id: 3, day: "Day4", workout_In_Min: 360),
    Daily(id: 4, day: "Day5", workout_In_Min: 1220),
    Daily(id: 5, day: "Day6", workout_In_Min: 750),
    Daily(id: 6, day: "Day7", workout_In_Min: 950)
    
]

//stats Data...
struct Stats : Identifiable {
    var id : Int
    var title : String
    var currentData : CGFloat
    var goal : CGFloat
    var color : Color
}
var stats_Data = [
    Stats(id: 0, title: "Running", currentData: 6.8, goal: 15, color: Color("running")),
    Stats(id: 1, title: "Energy Burn", currentData: 600, goal: 45, color: Color("energy")),
    Stats(id: 2, title: "Steps", currentData: 100, goal: 43, color: Color("steps")),
    Stats(id: 3, title: "Cycle", currentData: 100, goal: 34, color: Color("cycle"))
    
]
