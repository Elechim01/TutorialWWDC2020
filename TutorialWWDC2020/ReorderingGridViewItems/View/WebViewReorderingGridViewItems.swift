//
//  WebViewReorderingGridViewItems.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 15/12/21.
//

import SwiftUI
import WebKit

// WebView From UIKit...


struct WebViewReorderingGridViewItems: UIViewRepresentable {
    
    var url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        
        let view = WKWebView()
        view.load(URLRequest(url: url))
        view.isUserInteractionEnabled = false
        
//        Scaling Web View...
        view.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        return view
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
    
}

