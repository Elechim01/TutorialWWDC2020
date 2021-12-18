//
//  ViewDragAndDropApi.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 21/09/21.
//

import SwiftUI
import MobileCoreServices

struct ViewDragAndDropApi: View {
    
    var columns = Array(repeating: GridItem(.flexible(),spacing: 15), count: 2)
//    later we will gointo use this as delegate...
    @ObservedObject var delegate = ImgData()
    
    var body: some View {
        VStack(spacing: 15){
            //            Total Image Grid...
            ScrollView{
                LazyVGrid(columns: columns,spacing: 20) {
                    ForEach(delegate.totalImage){ image in
                        Image(image.image)
                            .resizable()
                            .frame(height: 150)
                            .cornerRadius(15)
                        //                        now going to add Drag and Drop Gesture
                            .onDrag {
//                             going to provie what data...
                                NSItemProvider(item: .some(URL(string: image.image)! as NSSecureCoding), typeIdentifier: String(kUTTypeURL))
                            }
                    }
                }
                .padding(.all)
            }
            //            Drop Area..
            ZStack{
                if delegate.selectedImages.isEmpty{
                    Text("Drop Images Here")
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
                ScrollView(.horizontal,showsIndicators: false){
                    HStack{
//                        image is unique so assigning it as id...
                        ForEach(delegate.selectedImages,id: \.image){ image in
                            if image.image != ""{
                                
                                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                                    Image(image.image)
                                        .resizable()
                                        .frame(width: 100,height: 100)
                                        .cornerRadius(15)
//                                    remove button...
                                    Button {
//                                        removing image from selected List...
//                                        adding animations...
                                        withAnimation(.easeOut){
                                            self.delegate.selectedImages.removeAll { chek ->Bool in
                                                if chek.image == image.image{return true}
                                                else{return false}
                                            }
                                        }
                                    } label: {
                                        Image(systemName: "xmark")
                                            .foregroundColor(.white)
                                            .padding(10)
                                            .background(Color.black)
                                            .clipShape(Circle())
                                    }

                                }
                            }
                        }
                        Spacer(minLength: 0)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            .padding(.top,10)
            //            if no images means default 100 height...
            .frame(height: delegate.selectedImages.isEmpty ? 100 : nil)
            //            for drop recogniztaion...
            .contentShape(Rectangle())
            .background(Color.white)
//            going to recive provieded data...
//            reciving same data type..
            .onDrop(of: [String(kUTTypeURL)], delegate: delegate)
        }
        .background(Color.black.opacity(0.05))
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct ViewDragAndDropApi_Previews: PreviewProvider {
    static var previews: some View {
        ViewDragAndDropApi()
    }
}

class ImgData: ObservableObject,DropDelegate {
    @Published var totalImage : [Img] = [
        Img(id: 0, image: "p0"),
        Img(id: 1, image: "p1"),
        Img(id: 2, image: "p2"),
        Img(id: 3, image: "p3"),
        Img(id: 4, image: "p4"),
        Img(id: 5, image: "p5"),
        Img(id: 6, image: "g1"),
        Img(id: 7, image: "g2"),
        Img(id: 8, image: "g3"),
        Img(id: 9, image: "g4"),
        Img(id: 10, image: "g5"),
        Img(id: 11, image: "g6"),
        Img(id: 12, image: "g7"),
        Img(id: 13, image: "g8")
    ]
    
    @Published var selectedImages : [Img] = []
    
    func performDrop(info: DropInfo) -> Bool {
        
//        adding image to bottom view...
        for provider in info.itemProviders(for: [String(kUTTypeURL)]) {
//            checking if its available..
            if provider.canLoadObject(ofClass: URL.self){
                print("url Loaded")
                let _ = provider.loadObject(ofClass: URL.self) { url, err  in
                    print(url!)
                    
//                    adding to selected array...
                    
//                    checking the array whether it is already added...
                    
                    let status = self.selectedImages.contains { check in
                        if check.image == "\(url)"{return true}
                        else{return false}
                    }
//                      safley appending...
                    if !status{
                        
//                        adding animation...
                        DispatchQueue.main.async {
                            withAnimation(.easeOut){
                                self.selectedImages.append(Img(id: self.selectedImages.count, image: "\(url!)"))
                            }
                        }
                        
                        
                       
                    }
                    
                    
                    
                }
            }else{
                print("cannot Be Loaded")
            }
        }
        
        return true
    }
}

struct Img: Identifiable {
    var id : Int
    var image : String
}
