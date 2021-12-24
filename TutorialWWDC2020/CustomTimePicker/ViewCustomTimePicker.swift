//
//  ViewCustomTimePicker.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 20/12/21.
//

import SwiftUI

struct ViewCustomTimePicker: View {
    var body: some View {
        HomeViewCustomTimePicker()
    }
}

struct ViewCustomTimePicker_Previews: PreviewProvider {
    static var previews: some View {
        ViewCustomTimePicker()
    }
}

struct HomeViewCustomTimePicker: View {
    
    @StateObject var dateModel = DateViewModelCustomTimePicker()
    
    var body: some View{
        
        ZStack{
            Text(dateModel.selectedDate,style: .time)
                .font(.largeTitle)
                .fontWeight(.bold)
                .onTapGesture {
//                    setting time as pteviews selected Time...
                    dateModel.setTime()
                    withAnimation(.spring()){
                        dateModel.showPicker.toggle()
                    }
                }
            
            if dateModel.showPicker{
                //            Picker View...
                VStack(spacing: 0){
                    
                    HStack(spacing: 18){
                        
                        Spacer()
                        
                        HStack(spacing: 0){
                            
                            Text("\(dateModel.hour):")
                                .font(.largeTitle)
                                .fontWeight(dateModel.changeToMin ? .light :  .bold)
                            //                        Changing On Tapping...
                                .onTapGesture {
                                    //                                updating angle values...
                                    dateModel.angle = Double(dateModel.hour * 30)
                                    dateModel.changeToMin = false
                                }
                            
                            Text("\(dateModel.minutes < 10 ? "0" : "") \(dateModel.minutes)")
                                .font(.largeTitle)
                                .fontWeight(dateModel.changeToMin ? .bold : .light)
                                .onTapGesture {
                                    dateModel.angle = Double(dateModel.minutes * 6)
                                    dateModel.changeToMin = true
                                }
                        }
                        
                        VStack(spacing: 8){
                            
                            Text("AM")
                                .font(.title2)
                                .fontWeight(dateModel.symbol == "AM" ? .bold : .light)
                                .onTapGesture {
                                    dateModel.symbol = "AM"
                                }
                            
                            Text("PM")
                                .font(.title2)
                                .fontWeight(dateModel.symbol == "PM" ? .bold : .light)
                                .onTapGesture {
                                    dateModel.symbol = "PM"
                                }
                        }
                        .frame(width: 50)
                        
                    }
                    .padding()
                    .foregroundColor(.white)
                    
                    //                 Circular Slider...
                    TimeSliderCustomTimePicker()
                    
                    HStack{
                        
                        Spacer()
                        
                        Button {
                            dateModel.generateTime()
                        } label: {
                            Text("Save")
                                .fontWeight(.bold)
                        }
                    }
                    .padding()
                    
                }
                //            Max Width...
                .frame(width: getWidthCustomTimePicker() - 120)
                .background(Color.primary)
                .cornerRadius(8)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.primary.opacity(0.3).ignoresSafeArea().onTapGesture(perform: {
                    
                    withAnimation(.spring()){
                        dateModel.showPicker.toggle()
                        dateModel.changeToMin = false
                    }
                }))
                .environmentObject(dateModel)
            }
            
        }
    }
}

// extending View to get Screen Size...
extension View{
    
    func getWidthCustomTimePicker() -> CGFloat {
        
        return UIScreen.main.bounds.width
    }
    
}


//Data
class DateViewModelCustomTimePicker: ObservableObject{
    
    @Published var selectedDate = Date()
    @Published var showPicker = false
    
    @Published var hour: Int = 12
    @Published var minutes: Int = 0
    
//     Switching Beteween Hours And Minutes...
    @Published var changeToMin = false
//    AM or PM
    @Published var symbol = "AM"
    
//    angle...
    @Published var angle: Double = 0
    
//    save button function...
    func generateTime(){
        let format = DateFormatter()
//        captial HH means 24 Hrs...
        format.dateFormat = "HH:mm"
        
        let correctHourValue = symbol == "AM" ? hour : hour + 12
        
        let date = format.date(from: "\(correctHourValue):\(minutes)")
        self.selectedDate = date!
        
        withAnimation {
            showPicker.toggle()
            changeToMin = false
        }
    }
    
    func setTime(){
        let calendar = Calendar.current
        
//        24 Hrs...
        hour = calendar.component(.hour, from: selectedDate)
        symbol = hour <= 12 ? "AM" : "PM"
        hour = hour == 0 ? 12: hour
        hour = hour <= hour ? hour : hour - 12
        
        minutes = calendar.component(.minute, from: selectedDate)
        
        angle = Double(hour * 30)
    }
    
}

struct TimeSliderCustomTimePicker: View {
    
    @EnvironmentObject var dateModel : DateViewModelCustomTimePicker
    
    var body: some View {
        GeometryReader{ reader in
            
            ZStack{
                
//                        Time Slider...
        let widdth = reader.frame(in: .global).width / 2
//                        Knob or Circle...
                Circle()
                    .fill(Color.blue)
                    .frame(width: 40, height: 40)
                    .offset(x: -widdth - 50)
                    .rotationEffect(.init(degrees: dateModel.angle))
                    .gesture(DragGesture().onChanged(onChanged(value: )).onEnded(onEnd(value: )))
                    .rotationEffect(.init(degrees: -90))


                ForEach(1...12,id:\.self){ index in

                    VStack {
                        Text("\(dateModel.changeToMin ? index * 5 : index)")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        //                                revering back the inside view...
                            .rotationEffect(.init(degrees: Double(-index) * 30))
                    }
                    .offset(y: -widdth + 50)
                    //                            rotating Views...
                    //                            12*30 = 360 degree...
                    .rotationEffect(.init(degrees: Double(index) * 30))
                }
                
//                Arrow
                
                Circle()
                    .fill(Color.blue)
                    .frame(width: 10, height: 10)
                    .overlay(
                        Rectangle()
                            .fill(Color.blue)
                            .frame(width: 2, height: width / 2)
                        
                        ,alignment: .bottom
                    )
                    .rotationEffect(.init(degrees: dateModel.angle))
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        //                maxheight...
        .frame(height: 300)
    }
    
//     gesture...
    func onChanged(value: DragGesture.Value){
//        getting angle..
        let vector = CGVector(dx: value.location.x, dy: value.location.y)
        
//        circle or knov size is 40
//        so radius = 20
        let radians = atan2(vector.dx - 20, vector.dy - 20)
        
        var angle = radians * 180 / .pi
        
        if angle < 0{
            angle = 360 + angle
        }
        print(angle)
        dateModel.angle = Double(angle)
        
//        disabling for minutes...
        if !dateModel.changeToMin{
//        rounding up the value...
            let roundValue = 30 * Int(dateModel.angle / 30)
            dateModel.angle = Double(roundValue)
        }else{
//            Updating Minutes...
            let progress = dateModel.angle / 360
            dateModel.minutes = Int(progress * 60)
        }
        
    }
    
    func onEnd(value: DragGesture.Value){
        
        if !dateModel.changeToMin{
        
//        updating Hour value...
        dateModel.hour = Int(dateModel.angle / 30)
        
//        updating picker to minutes...
        withAnimation {
            
//            setting to minute Value...
            dateModel.angle = Double(dateModel.minutes * 6)
            dateModel.changeToMin = true
        }
        
    }
        
    }
}
