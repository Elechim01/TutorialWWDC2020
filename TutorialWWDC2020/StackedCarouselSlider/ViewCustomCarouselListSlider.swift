//
//  ViewCustomCarouselListSlider.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 20/10/21.
//

import SwiftUI

struct ViewCustomCarouselListSlider: View {
    
//    40 = padding horizontal..
//    60 = 2 card to right side...
    var width = UIScreen.main.bounds.width - (40 + 60)
    var height = UIScreen.main.bounds.height / 2
    @State var books = [
//        Make Sure is in ascendenting Order...
        Book(id: 0, image: "p1", title: "prova1", author: "www", rating: 1, offset: 0),
        Book(id: 1, image: "p2", title: "prova2", author: "www", rating: 1, offset: 0),
        Book(id: 2, image: "p3", title: "prova3", author: "www", rating: 1, offset: 0),
        Book(id: 3, image: "p4", title: "prova4", author: "www", rating: 1, offset: 0),
    ]
    @State var swiped = 0
    var body: some View {
        VStack{
            HStack{
                Text("Custom Carousel")
                    .font(.title)
                    .fontWeight(.heavy)
                
                Spacer(minLength: 0)
                
                Button {
                    
                } label: {
                    Image(systemName: "circle.grid.2x2.fill")
                        .font(.system(size: 22))
                }
            }
            .foregroundColor(.white)
            .padding()
            
            Spacer(minLength: 0)
            
            ZStack{
//                since its zstack it overlay one on another so reversed...
                ForEach(books.reversed()){book in
                    HStack{
                        ZStack {
                            Image(book.image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: width, height: getHeight(index: book.id))
                                .cornerRadius(25)
    //                        Little Shadow...
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5)
                            
//                            Read More Button...
                            CardViewCarouselList(card: book)
                                .frame(width: width, height: getHeight(index: book.id))
                        }
                        
                        Spacer(minLength: 0)
                    }
//                    Content Shape For Drag Gesture...
                    .contentShape(Rectangle())
                    .padding(.horizontal,20)
                    .offset(x: book.id - swiped < 3 ? CGFloat(book.id - swiped) * 30 : 60)
//                    gesture....
                    .offset(x: book.offset)
                    .gesture(DragGesture().onChanged({ value in
                        withAnimation {
                            onScroll(value: value.translation.width, index: book.id)
                        }
                    }).onEnded({ value in
                        withAnimation {
                            onEnd(value: value.translation.width, index: book.id)
                        }
                    }))
                }
            }
//            max Height...
            .frame(height: height)
            
            PageViewController(total: books.count, current: $swiped)
                .padding(.top,25)
            
            Spacer(minLength: 0)
        }
        .background(Color("bg1").ignoresSafeArea(.all,edges: .all))
    }
    
// dynamic height change...
    func getHeight(index : Int)-> CGFloat{
//        tow card = 80
//        all other are 80 at background...
//        automatc height and offset ahjusting...
        return height - (index - swiped < 3 ? CGFloat(index - swiped) * 40 : 80)
    }
    
    func onScroll(value : CGFloat,index: Int){
        if value < 0{
//            left Swipe...
            if index != books.last!.id{
                books[index].offset = value
            }else{
//                ring Swipe..
//                Safe Check...
                if index > 0{
                    books[index - 1].offset = -(width + 60) + value
                }
            }
        }
    }
    
    func onEnd(value : CGFloat,index: Int){
        if value < 0{
            if -value > width / 2 && index != books.last!.id{
                books[index].offset = -(width + 60)
                swiped += 1
            }else{
                books[index].offset = 0
            }
        }else{
            if index > 0{
                if value > width / 2{
                    books[index - 1].offset = 0
                    swiped -= 1
                }else{
                    books[index - 1].offset = -(width + 60)
                }
            }
        }
    }
    
}

struct ViewCustomCarouselListSlider_Previews: PreviewProvider {
    static var previews: some View {
        ViewCustomCarouselListSlider()
    }
}


struct CardViewCarouselList : View {
    var card : Book
    var body: some View{
        VStack{
            
//            you can display all details
//            I'm dislaying only read button......
            Spacer(minLength: 0)
            
            HStack{
                
                Button {
                    
                } label: {
                    Text("Read Now")
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical,5)
                        .padding(.horizontal,10)
                        .background(Color("purple1"))
                        .clipShape(Capsule())
                }
                Spacer(minLength: 0)
            }
            .padding()
            .padding(.bottom,10)
        }
    }
}

//Carousel Model Book Data...

struct Book: Identifiable {
    var id : Int
    var image: String
    var title: String
    var author : String
    var rating : Int
    var offset : CGFloat
}


// Pagng Control...
struct PageViewController: UIViewRepresentable {
    
    var total : Int
    @Binding var current : Int
    
    func makeUIView(context: Context) -> UIPageControl {
            let view = UIPageControl()
            view.numberOfPages = total
            view.currentPage = current
            view.currentPageIndicatorTintColor = .white
            view.preferredIndicatorImage = UIImage(systemName: "book.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22))
            view.backgroundStyle = .prominent
        return view
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = current
    }
}
