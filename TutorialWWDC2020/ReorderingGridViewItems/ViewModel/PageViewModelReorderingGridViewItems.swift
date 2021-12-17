//
//  PageViewModelReorderingGridViewItems.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 15/12/21.
//

import SwiftUI

class PageViewModelReorderingGridViewItems: ObservableObject {
    
//    Selected tab....
    
    @Published var selectedTab = "tabs"
    
   @Published var urlsReorderingGridViewItems = [
        PageReorderingGridViewItems(url: URL(string: "https://www.google.com")),
        PageReorderingGridViewItems(url: URL(string: "https://www.facebook.com")),
        PageReorderingGridViewItems(url: URL(string: "https://www.apple.com")),
        PageReorderingGridViewItems(url: URL(string: "https://www.twitter.com")),
        PageReorderingGridViewItems(url: URL(string: "https://www.gmail.com")),

    ]
    
//  Currently Dragging Page...
    @Published var currentPage: PageReorderingGridViewItems?
    
}

