//
//  PhotosUIPHPickerView.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 23/09/21.
//

import SwiftUI
import  PhotosUI

struct PhotosUIPHPickerView: View {
    
    @State var images : [UIImage] = []
    @State var picker = false
    
    var body: some View {
        VStack{
            if !images.isEmpty{
                ScrollView(.horizontal, showsIndicators: false, content: {
                    HStack(spacing: 15){
                        ForEach(images,id: \.self){img in
                            Image(uiImage: img)
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width - 30, height: 250)
                                .cornerRadius(20)
                        }
                    }
                })
            }
            else{
                Button(action: {
                    picker.toggle()
                }, label: {
                    Text("Pick Images")
                        .foregroundColor(.white)
                        .padding(.vertical,10)
                        .padding(.horizontal,35)
                        .background(Color.blue)
                        .clipShape(Capsule())
                })
            }
        }
//        calling picker...
        .sheet(isPresented: $picker) {
            ImagePicker1(images:$images ,picker: $picker)
        }
    }
}

struct PhotosUIPHPickerView_Previews: PreviewProvider {
    static var previews: some View {
        PhotosUIPHPickerView()
    }
}

// New Image Picker API....
struct ImagePicker1: UIViewControllerRepresentable {
    func makeCoordinator() -> Coordinator {
        return ImagePicker1.Coordinator(parent1: self)
    }
    
    
    @Binding var images : [UIImage]
    @Binding var picker : Bool
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        
        var confing = PHPickerConfiguration()
//        You can also select videos using this picker...
        confing.filter = .images
//        0 is used for multiple selection...
        confing.selectionLimit = 0
        let picker = PHPickerViewController(configuration: confing)
//        adding delegate..
        picker.delegate = context.coordinator
        return picker
        
    }
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    class Coordinator: NSObject,PHPickerViewControllerDelegate {
        
        var parent : ImagePicker1
        
        init(parent1 : ImagePicker1) {
            parent = parent1
        }
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
//            closing picker...
            parent.picker.toggle()
            for img in results{
//                checkeing whether the image can be loaded....
                if img.itemProvider.canLoadObject(ofClass: UIImage.self){
//                    retreveing the selected Image...
                    img.itemProvider.loadObject(ofClass: UIImage.self) { image, err in
                        guard let image1 = image else{
                            print(err)
                            return
                        }
//                        appending image...
                        self.parent.images.append(image1 as! UIImage)
                    }
                }else{
//                    cannot be loaded...
                    print("cannot be loaded")
                }
            }
        }
    }
}
