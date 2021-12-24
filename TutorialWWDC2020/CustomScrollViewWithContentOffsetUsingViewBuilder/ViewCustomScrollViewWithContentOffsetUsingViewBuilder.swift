//
//  ViewCustomScrollViewWithContentOffsetUsingViewBuilder.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 22/12/21.
//

import SwiftUI

struct ViewCustomScrollViewWithContentOffsetUsingViewBuilder: View {
    var body: some View {
        HomeViewCustomScrollViewWithContentOffsetUsingViewBuilder()
    }
}

struct ViewCustomScrollViewWithContentOffsetUsingViewBuilder_Previews: PreviewProvider {
    static var previews: some View {
        ViewCustomScrollViewWithContentOffsetUsingViewBuilder()
    }
}

struct HomeViewCustomScrollViewWithContentOffsetUsingViewBuilder: View {
   
//    Offset Value...
//    SInce were going to fetch offsett for both vertical and horizontal so were using CGPoint..
    @State var offset: CGPoint = .zero
    var body: some View{
        
        NavigationView{
            
            CustomScrollViewCustomScrollViewWithContentOffsetUsingViewBuilder(offset: $offset, showsIndicators: true, axis: .horizontal){
                
//                Your General Scroll View Content..
                LazyVStack(spacing: 15){
                    
                    ForEach(1...30,id:\.self) {_ in
                        
                        HStack(spacing: 15){
                            
                            Circle()
                                .fill(Color.gray.opacity(0.6))
                                .frame(width: 70, height: 70)
                            
                            VStack(alignment: .leading, spacing: 15) {
                                
                                Rectangle()
                                    .fill(Color.gray.opacity(0.6))
                                    .frame(height: 15)
                                
                                Rectangle()
                                    .fill(Color.gray.opacity(0.6))
                                    .frame(height: 15)
                                    .padding(.trailing,30)
                            }
                            .frame(width: 70)
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.top)
                
            }
            .navigationTitle("Offset: \(String(format: "%.1f",offset.x))")
        }
    }
}

// building Custom ScrollView Using View Builder...
struct CustomScrollViewCustomScrollViewWithContentOffsetUsingViewBuilder<Content : View>: View{
    
//    to Hold Our View...
//    Or to capture the described view...
    var content: Content
    
    @Binding var offset: CGPoint
    var showsIndicators: Bool
    var axis: Axis.Set
    
//    since it will carry multiple views...
//    so it will be a closure and it will return View...
    init(offset: Binding<CGPoint>,showsIndicators: Bool,axis: Axis.Set,@ViewBuilder content: ()->Content){
        
        self.content = content()
        self._offset = offset
        self.showsIndicators = showsIndicators
        self.axis = axis
    }
    
//    Getting Extract Start Offset And Minu from Current Offset...
//    So taht crt offset will be obtained...
    @State var startOffset: CGPoint = .zero
    
    var body: some View{
        ScrollView(axis, showsIndicators: showsIndicators) {
            
            content
//          Getting Offset...
                .overlay(
                    
//                    Using Geometry Reader to get offset..
                    
                    GeometryReader{ proxy -> Color in
                        
                        let rect = proxy.frame(in: .global)
                        
                        if startOffset == .zero{
                            DispatchQueue.main.async {
                                startOffset = CGPoint(x: rect.minX, y: rect.minY)
                            }
                        }
                        
                        DispatchQueue.main.async {
                            
//                            Minus From Current...
                            self.offset = CGPoint(x:startOffset.x - rect.minX, y: startOffset.y - rect.minY)
                        }
                        
                        return Color.clear
                    }
//                    Since were also fetching horizontal offset...
//                    so setting width to full so taht minX will be Zero...
                    .frame(width: UIScreen.main.bounds.width, height: 0)
                    
                    ,alignment: .top
                )
        }
    }
    
}
