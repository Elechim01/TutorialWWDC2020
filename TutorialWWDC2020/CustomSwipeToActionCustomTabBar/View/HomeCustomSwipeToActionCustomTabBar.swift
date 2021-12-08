//
//  HomeCustomSwipeToActionCustomTabBar.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 07/12/21.
//

import SwiftUI

struct HomeCustomSwipeToActionCustomTabBar: View {
    
    @State var size = "Medium"
    @State var currentTab = "All"
    
    @State var itemsCustomSwipeToActionCustomTabBar = [
        ItemsCustomSwipeToActionCustomTabBar(title: "prova1", price: "30€", subTitle: "pr1", image: "g1"),
        ItemsCustomSwipeToActionCustomTabBar(title: "prova2", price: "40€", subTitle: "pr2", image: "g2"),
        ItemsCustomSwipeToActionCustomTabBar(title: "prova3", price: "50€", subTitle: "pr3", image: "g3"),
    ]
    
    @GestureState var isDragging = false
    
//    adding cart items...
    @State var cart: [ItemsCustomSwipeToActionCustomTabBar] = []
    
    var body: some View {
        
        VStack{
            
            HStack{
                
                Button {
                    
                } label: {
                    Image(systemName: "line.horizontal.3.decrease")
                        .font(.title)
                        .foregroundColor(.black)
                }

                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "cart")
                        .font(.title)
                        .foregroundColor(.black)
                }
                .overlay(
//                    Cart Count...
                    Text("\(cart.count)")
                        .font(.caption)
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                        .frame(width: 20, height: 20)
                        .background(Color.black)
                        .clipShape(Circle())
                        .offset(x: 15, y: -22)
//                        disbling if no items...
                        .opacity(cart.isEmpty ? 0 : 1)
                )
            }
            .padding(.horizontal)
            .padding(.top)
            .padding(.bottom,10)
            
            ScrollView{
                VStack{
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 8) {
                            
                            Text("Furniture in \nUnique Style")
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                                .foregroundColor(.black)
                            
                            Text("We have wide range of furnitures")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .fontWeight(.bold)
                        }
                        
                        Spacer(minLength: 15)
                        
//                        Menu Button...
                        
                        Menu {
                            Button {
                                size = "Small"
                            } label: {
                                Text("Small")
                            }
                            
                            Button {
                                size = "Medium"
                            } label: {
                                Text("Medium")
                            }
                            
                            Button {
                                size = "Large"
                            } label: {
                                Text("Large")
                            }

                        } label: {
                            Label {
                                Text(size)
                                    .foregroundColor(.white)
                            } icon: {
                                Image(systemName: "slider.vertical.3")
                                    .foregroundColor(.white)
                            }
                            .padding(.vertical,10)
                            .padding(.horizontal)
                            .background(Color.black)
                            .clipShape(Capsule())

                        }

                    }
                    .padding()
                    
                    HStack(spacing: 0){
                        ForEach(tabsCustomSwipeToActionCustomTabBar,id:\.self){ tab in
                            Button {
                                currentTab = tab
                            } label: {
                                Text(tab)
                                    .fontWeight(.bold)
                                    .foregroundColor(currentTab == tab ? .black : .gray)
                            }
                            
                            if tab != tabsCustomSwipeToActionCustomTabBar.last{
                                Spacer(minLength: 0)
                            }
                        }
                    }
                    .padding()
                    
                    ForEach(itemsCustomSwipeToActionCustomTabBar.indices){ index in
//                        Card View...
                        ZStack {
                            
                            Color.black
                                .cornerRadius(20)
                            
                            Color.purple
                                .cornerRadius(20)
                                .padding(.trailing,65)
                            
//                            Button...
                            HStack{
                                Spacer()
                                
                                Button {
                                    
                                } label: {
                                    Image(systemName: "suit.heart")
                                        .font(.title)
                                        .foregroundColor(.white)
//                                    default frame..
                                        .frame(width: 65)
                                }
                                
                                Button {
                                    addCart(index: index)
                                } label: {
                                    
//                                    changing cart image...
                                    Image(systemName: checkCart(index: index) ? "cart.badge.minus" : "cart.badge.plus")
                                        .font(.title)
                                        .foregroundColor(.white)
//                                    default frame..
                                        .frame(width: 65)
                                }

                            }
                            
                            CardViewCustomSwipeToActionCustomTabBar(item: itemsCustomSwipeToActionCustomTabBar[index])
                                .offset(x: itemsCustomSwipeToActionCustomTabBar[index].offset)
                                .gesture(DragGesture()
                                            .updating($isDragging, body: { value, state, _ in
//                                    so we can validate for correct drag..
                                    state = true
                                    onChanged(value: value, index: index)
                                })
//                                            .onChanged({ value in
//                                    onChanged(value: value, index: index)
//                                })
                                            .onEnded({ value in
                                    onEnd(value: value, index: index)
                                })
                                )
//                            drag gesture...
                        }
                        .padding(.horizontal)
                        .padding(.top)
                    }
                }
                .padding(.bottom,100)
            }
        }
    }
    
//    cheking cart and adding item...
    func checkCart(index: Int) -> Bool {
        return cart.contains { item in
            return item.id == itemsCustomSwipeToActionCustomTabBar[index].id
        }
    }
    
    func addCart(index: Int){
        if checkCart(index: index){
            cart.removeAll { item  in
                return item.id == itemsCustomSwipeToActionCustomTabBar[index].id
            }
        }else{
            cart.append(itemsCustomSwipeToActionCustomTabBar[index])
        }
//        closing after added...
        withAnimation {
            itemsCustomSwipeToActionCustomTabBar[index].offset = 0

        }
    }
    
    func onChanged(value: DragGesture.Value,index: Int){
        
        if value.translation.width < 0 && isDragging{
            itemsCustomSwipeToActionCustomTabBar[index].offset = value.translation.width
        }
    }

//    onEnd is not working properly...
    func onEnd(value: DragGesture.Value,index: Int){
        withAnimation {
            
//            65 + 65 = 130
            if -value.translation.width >= 100{
                itemsCustomSwipeToActionCustomTabBar[index].offset = -130
            }else{
                itemsCustomSwipeToActionCustomTabBar[index].offset = 0
            }
            
           
        }
    }

}

var tabsCustomSwipeToActionCustomTabBar = ["Tables","Chairs","Lamps","All"]

struct HomeCustomSwipeToActionCustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        ViewCustomSwipeToActionCustomTabBar()
    }
}
