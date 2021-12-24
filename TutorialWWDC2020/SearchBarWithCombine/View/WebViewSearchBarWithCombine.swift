//
//  WebViewSearchBarWithCombine.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 21/12/21.
//

import SwiftUI
import WebKit

struct WebViewSearchBarWithCombine: UIViewRepresentable {
    
    var url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let view = WKWebView()
        view.load(URLRequest(url: url))
        
        return view
        
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
    
}

