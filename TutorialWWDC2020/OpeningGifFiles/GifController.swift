//
//  GifController.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 27/10/21.
//

import SwiftUI
import GiphyUISDK
import GiphyUISDKWrapper
//import GiphyCoreSDK

struct GIFController: UIViewControllerRepresentable {
    
    func makeCoordinator() -> Coordinator {
        return GIFController.Coordinator(parent: self)
    }
    
    @Binding var url : String
    @Binding var present : Bool
    
    func makeUIViewController(context: Context) -> GiphyViewController {
        Giphy.configure(apiKey: "uen5KwMyC9dI1k8BPBqZVRdf9PrW9H9f")
        let controller = GiphyViewController()
//        Anityng you need...
        controller.mediaTypeConfig = [.emoji,.gifs,.stickers,.text]
        controller.delegate = context.coordinator
//        For full Screen....
        GiphyViewController.trayHeightMultiplier = 1.05
        controller.theme = GPHTheme(type: .light)
        return controller
    }
    func updateUIViewController(_ uiViewController: GiphyViewController, context: Context) {
        
    }
   
    
    class Coordinator: NSObject,GiphyDelegate {
        
        var parent : GIFController
        init(parent: GIFController) {
            self.parent = parent
        }
        
        func didDismiss(controller: GiphyViewController?) {
            
        }
        
        func didSelectMedia(giphyViewController: GiphyViewController, media: GPHMedia) {
//            retreveing url...
            let url = media.url(rendition: .fixedWidth, fileType: .gif)
            parent.url = url ?? ""
            parent.present.toggle()
        }
    }
    
}
