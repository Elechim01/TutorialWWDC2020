//
//  ViewAnalogClockApp.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 26/10/21.
//

import SwiftUI

struct ViewAnalogClockApp: View {
    @State  var isDark: Bool = false
    var width = UIScreen.main.bounds.width
    @State var curret_Time = Time(min: 0, sec: 0, hour: 0)
    @State var reciver = Timer.publish(every: 1, on: .current, in: .default).autoconnect()
    var body: some View {
        NavigationView{
            VStack{
                
                HStack{
                    Text("Analog Cock")
                        .font(.title)
                        .fontWeight(.heavy)
                    
                    Spacer(minLength: 0)
                    
                    Button {
                        isDark.toggle()
                    } label: {
                        Image(systemName: isDark ? "sun.min.fill" : "moon.fill")
                            .font(.system(size: 22))
                            .foregroundColor(isDark ? .black : .white)
                            .padding()
                            .background(Color.primary)
                            .clipShape(Circle())
                    }
                    
                }
                .padding()
                
                Spacer(minLength: 0)
                
                ZStack{
                    Circle()
                        .fill((isDark ? Color.white : Color.black).opacity(0.1))
                    
//                    Seconds And Min dots...
                    
                    ForEach(0..<60,id: \.self) { i in
                        Rectangle()
                            .fill(Color.primary)
//                        60 / 12 = 5
                            .frame(width: 2, height: (i % 5) == 0 ? 15 : 5 )
                            .offset(y: (width - 110) / 2)
                            .rotationEffect(.init(degrees: Double(i) * 6))
                    }
                    
//                    Sec...
                    Rectangle()
                        .fill(Color.primary)
                        .frame(width: 2, height: (width - 180) / 2)
                        .offset(y: -(width - 180) / 4)
                        .rotationEffect(.init(degrees: Double(curret_Time.sec) * 6))
//                    Min...
                    Rectangle()
                        .fill(Color.primary)
                        .frame(width: 4, height: (width - 200) / 2)
                        .offset(y: -(width - 200) / 4)
                        .rotationEffect(.init(degrees: Double(curret_Time.min) * 6))
//                    Hour...
                    Rectangle()
                        .fill(Color.primary)
                        .frame(width: 4.5, height: (width - 240) / 2)
                        .offset(y: -(width - 240) / 4)
                        .rotationEffect(.init(degrees:  Double(curret_Time.hour + curret_Time.min / 60) * 30))
                    
//                    Center circle...
                    Circle()
                        .fill(Color.primary)
                        .frame(width: 15, height: 15)
                }
                .frame(width: width - 80, height: width - 80)
                
//                getting Locale Region Name...
                Text(Locale.current.localizedString(forRegionCode: Locale.current.regionCode!) ?? "")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .padding(.top,35)
                
                Text(gettime())
                    .font(.system(size: 45))
                    .fontWeight(.heavy)
                    .padding(.top,10)
                
                Spacer(minLength: 0)
            }
            .navigationBarHidden(true)
            .preferredColorScheme(isDark ? .dark : .light)
        }
        .onAppear(perform: {
            let calendar = Calendar.current
            let min = calendar.component(.minute, from: Date())
            let sec = calendar.component(.second, from: Date())
            let hour = calendar.component(.hour, from: Date())
            withAnimation(Animation.linear(duration: 0.01)){
                self.curret_Time = Time(min: min, sec: sec, hour: hour)
            }
        })
        .onReceive(reciver) { _ in
            let calendar = Calendar.current
            let min = calendar.component(.minute, from: Date())
            let sec = calendar.component(.second, from: Date())
            let hour = calendar.component(.hour, from: Date())
            withAnimation(Animation.linear(duration: 0.01)){
                self.curret_Time = Time(min: min, sec: sec, hour: hour)
            }
        }
    }
    func gettime() -> String {
        let format = DateFormatter()
        format.dateFormat = "hh:mm a"
        
        return format.string(from: Date())
    }
}

//Calculating time...
struct Time {
    var min: Int
    var sec: Int
    var hour: Int
}

struct ViewAnalogClockApp_Previews: PreviewProvider {
    static var previews: some View {
        ViewAnalogClockApp()
    }
}
