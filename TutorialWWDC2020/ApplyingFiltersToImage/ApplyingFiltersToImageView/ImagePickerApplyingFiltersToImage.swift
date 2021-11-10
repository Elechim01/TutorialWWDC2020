//
//  ImagePickerApplyingFiltersToImage.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 08/11/21.
//

import SwiftUI
import PhotosUI
import SDWebImageSwiftUI

struct ImagePickerApplyingFiltersToImage: UIViewControllerRepresentable {
    

    @Binding var picker: Bool
    @Binding var imageData : Data
    
    func makeCoordinator() -> Coordinator {
        return ImagePickerApplyingFiltersToImage.Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        let picker = PHPickerViewController(configuration: PHPickerConfiguration())
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    class Coordinator: NSObject,PHPickerViewControllerDelegate {
        
        var parent : ImagePickerApplyingFiltersToImage
        
        init(parent: ImagePickerApplyingFiltersToImage) {
            self.parent = parent
        }
        
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//            cheking image is selected or cancelled...
            if !results.isEmpty{
                
//                cheking image can be loaded..
                if results.first!.itemProvider.canLoadObject(ofClass: UIImage.self){
                    results.first!.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { image, err in
                        DispatchQueue.main.async {
                            self.parent.imageData = (image as! UIImage).pngData()!
                            self.parent.picker.toggle()
                        }
                    })
                }
                
            }else{
                self.parent.picker.toggle()
            }
        }
    }
}
