//
//  HomeChatUIImagePicker.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 14/09/21.
//

import SwiftUI

struct HomeChatUIImagePicker: View {
    
    @State var message = ""
    @State var imagePicker = false
    @State var imgData : Data = Data(count: 0)

    @StateObject var allMessages = Messages()
    
    var body: some View {
        VStack{
            ZStack {
                HStack{
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 22))
                            .foregroundColor(.white)
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "gear")
                            .font(.system(size: 22))
                            .foregroundColor(.white)
                    })
                }
                
                VStack(spacing: 5, content: {
                    Text("Catherine")
                        .fontWeight(.bold)
                    
                    Text("Active")
                        .font(.caption)
                })
                .foregroundColor(.white)
            }
            .padding(.all)
            
            VStack{
//                Displayg Message....
                ScrollView(.vertical, showsIndicators: false, content: {
                    ScrollViewReader{ reader in
                        VStack(spacing: 20){
                            ForEach(allMessages.messages){ msg in
//                                    Chat bubbles...
                                ChatBubble(msg: msg)
                            }
//                            when ever a new data is inserted scroll to bottom....
                            .onChange(of: allMessages.messages , perform: { value in
//                                scrolling only user message....
                                if value.last!.myMsg{
                                    reader.scrollTo(value.last?.id)
                                }
                            })
                        }
                        .padding([.horizontal,.bottom])
                        .padding(.top,25)
                    }
                })
                
                HStack(spacing: 15) {
                    
                    HStack(spacing: 15){
                        TextField("Message", text: self.$message)
                        Button(action: {
//                             toogling image picker...
                            imagePicker.toggle()
                            
                        }, label: {
                            Image(systemName: "paperclip.circle.fill")
                                .font(.system(size: 22))
                                .foregroundColor(.gray)
                        })
                    }
                    .padding(.vertical,12)
                    .padding(.horizontal)
                    .background(Color.black.opacity(0.06))
                    .clipShape(Capsule())
                    
//                    send Button...
//                    hiding view...
                    if message != ""{
                        Button(action: {
//                            appending message...
                            
//                            adding animation....
                            withAnimation(.easeIn){
                                allMessages.messages.append(Message(id: Date(), message: message, myMsg: true, profilePic: "p1", photo: nil))
                            }
                            message = ""
                            
                        }, label: {
                            Image(systemName: "paperplane.fill")
                                .font(.system(size: 22))
                                .foregroundColor(Color("Color"))
                                //                        rotating the image...
                                .rotationEffect(.init(degrees: 45))
                                //                            adjusting padding shape...
                                .padding(.vertical,12)
                                .padding(.leading,12)
                                .padding(.trailing,17)
                                .background(Color.black.opacity(0.07))
                                .clipShape(Circle())
                        })
                    }
                }
                .padding(.horizontal)
                .animation(.easeOut)
            }
//            since bottom edge is ignored...
            .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            .background(Color.white)
            .clipShape(RoundShape())
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color("Color").edgesIgnoringSafeArea(.top))
//        Full Screen Image Picker....
        .fullScreenCover(isPresented: self.$imagePicker, onDismiss: {
//            when ever image picker closes...
//            verifying if image is selected or cancelled...
            if self.imgData.count != 0{
                allMessages.writeMessage(id: Date(), msg: "", photo: self.imgData, myMsg: true, profilePic: "p1")
            }
            
        }, content: {
            ImagePicker(imagePicker: self.$imagePicker, imageData: self.$imgData)
        })
    }
}

struct HomeChatUIImagePicker_Previews: PreviewProvider {
    static var previews: some View {
        HomeChatUIImagePicker()
    }
}

// Chat Bubbles...
struct ChatBubble: View {
    
    var msg: Message
    
    var body: some View{
        
//        Automatic scroll To Bottom....
//        First Assigning Id To Each Row....
        
        HStack(alignment: .top,spacing: 10){
            if msg.myMsg{
//                pushing msg to left..
                
//                minimum space...
                  
//                  Modifying for Image...
                
                
                Spacer(minLength: 25)
                if msg.photo == nil{
                    
                    Text(msg.message)
                        .padding(.all)
                        .background(Color.black.opacity(0.06))
                        .clipShape(BubbleArrow(myMsg: msg.myMsg))
                }else{
                    Image(uiImage: UIImage(data: msg.photo!)!)
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width - 150, height: 150)
                        .clipShape(BubbleArrow(myMsg: msg.myMsg))
                }
//                Profile Image...
                Image(msg.profilePic)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .clipShape(BubbleArrow(myMsg: msg.myMsg))
                
            }else{
                
                //                  pushing msg to right...
                //                Profile Image...
                Image(msg.profilePic)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                
                if msg.photo == nil{
                    
                    Text(msg.message)
                        .foregroundColor(.white)
                        .padding(.all)
                        .background(Color("Color"))
                        .clipShape(BubbleArrow(myMsg: msg.myMsg))
                }else{
                    Image(uiImage: UIImage(data: msg.photo!)!)
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width - 150, height: 150)
                        .clipShape(BubbleArrow(myMsg: msg.myMsg))
                }
                
                Spacer(minLength: 25)
            }
        }
        .id(msg.id)
    }
}

// Bubble Arrow...
struct BubbleArrow: Shape {
    
    var myMsg : Bool
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: myMsg ?  [.topLeft,.bottomLeft,.bottomRight] : [.topRight,.bottomLeft,.bottomRight], cornerRadii: CGSize(width: 10, height: 10))
        return Path(path.cgPath)
    }
}


// Custom Rounded Shape...
struct RoundShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 35, height: 35))
        return Path(path.cgPath)
    }
}

//Model data for message...
struct Message : Identifiable,Equatable {
    var id : Date
    var message : String
    var myMsg : Bool
    var profilePic : String
    var photo : Data?
}
class Messages: ObservableObject {
    @Published var messages : [Message] = []
    
//    samples data...
    init() {
        let strings = ["Hii","Hello !!!!!","What's Up?","Nothing  "]
        for i in 0...strings.count - 1 {
//            simple logic two side message View...
            messages.append(Message(id: Date(), message: strings[i], myMsg: i % 2 == 0 ? true : false, profilePic: i % 2 == 0 ? "p1" : "p2"))
        }
        
    }
    
    
    func writeMessage(id: Date, msg: String, photo: Data?,myMsg : Bool,profilePic: String){
        messages.append(Message(id: id, message: msg, myMsg: myMsg, profilePic: profilePic, photo: photo))
    }
}

//Image Picker....
struct ImagePicker: UIViewControllerRepresentable {
    
    func makeCoordinator() -> Coordinator {
        return ImagePicker.Coordinator(parent1: self)
    }
    
    @Binding var imagePicker : Bool
    @Binding var imageData : Data
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    class Coordinator: NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
        var parent : ImagePicker
        init(parent1 : ImagePicker) {
             parent = parent1
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.imagePicker.toggle()
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            let image = info[.originalImage] as! UIImage
            parent.imageData = image.jpegData(compressionQuality: 0.5)!
            parent.imagePicker.toggle()
        }
    }
}
