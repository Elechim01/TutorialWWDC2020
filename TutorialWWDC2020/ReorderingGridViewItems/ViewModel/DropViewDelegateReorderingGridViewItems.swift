//
//  DropViewDelegateReorderingGridViewItems.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 15/12/21.
//

import SwiftUI

//Drop Delegate functions...
struct DropViewDelegateReorderingGridViewItems: DropDelegate {
   
    var page : PageReorderingGridViewItems
    var pageData: PageViewModelReorderingGridViewItems
    
    func performDrop(info: DropInfo) -> Bool {
        
//   Comment This Just a try...
        
        pageData.currentPage = nil
        
        return true
    }
    
//    When User Dragged Into new Page...
    func dropEntered(info: DropInfo) {
        
//        solo una prova...
        if pageData.currentPage == nil{
            pageData.currentPage = page
        }
        
        
//        Getting From And To Index...
        
//        From Index...
        let fromIndex = pageData.urlsReorderingGridViewItems.firstIndex { page in
            return page.id == pageData.currentPage?.id
        } ?? 0
        
//        To Index...
        let toIndex = pageData.urlsReorderingGridViewItems.firstIndex { page in
            return page.id == self.page.id
        } ?? 0
        
//        Safe Check if both are not same...
        if fromIndex != toIndex{
//            Animation...
            withAnimation(.default){
//                Swapping Data...
//            Swapping Data...
                let fromPage = pageData.urlsReorderingGridViewItems[fromIndex]
                pageData.urlsReorderingGridViewItems[fromIndex] = pageData.urlsReorderingGridViewItems[toIndex]
                pageData.urlsReorderingGridViewItems[toIndex] = fromPage
            }
        }
    }
    
//    setting Action as Move...
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
    
}

