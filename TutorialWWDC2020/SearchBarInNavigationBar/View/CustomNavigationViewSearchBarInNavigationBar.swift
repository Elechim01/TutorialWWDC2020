//
//  CustomNavigationViewSearchBarInNavigationBar.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 08/12/21.
//

import SwiftUI

struct CustomNavigationViewSearchBarInNavigationBar: UIViewControllerRepresentable {
    
    func makeCoordinator() -> Coordinator {
        return CustomNavigationViewSearchBarInNavigationBar.Coordinator(parent: self)
    }
    
//    integrating UiKit Navigation controller With SwiftUi View...
    var view : AnyView
    
//    Ease Of Use..
    var largeTitle: Bool
    var title: String
    var placeHolder: String
    
//    onSearch And OnCancel Closures...
    var onSearch: (String)->()
    var onCancel: ()->()
    
//    require closure on Call...
    init(view:AnyView,placeHolder: String? = "Search",largeTitle: Bool? = true,title:String ,onSearch: @escaping (String)->(),onCancel: @escaping ()->()){
        
        self.title = title
        self.largeTitle = largeTitle!
        self.placeHolder = placeHolder!
        self.view = view
        self.onSearch = onSearch
        self.onCancel = onCancel
    }
    
    func makeUIViewController(context: Context) -> UINavigationController {
        
//        request SwiftUi view...
        let childview = UIHostingController(rootView: view)
        
        let controller = UINavigationController(rootViewController: childview)
        
//        Nav Bar Data...
        controller.navigationBar.topItem?.title = title
        controller.navigationBar.prefersLargeTitles = largeTitle
        
//        search Bar...
        
        let searchController = UISearchController()
        searchController.searchBar.placeholder = placeHolder
        
//        setting delegate...
        searchController.searchBar.delegate = context.coordinator
        
//        setting Search Bar In Navbar...
//        disabling hide on scroll..
        
//        disabling dim bg...
        searchController.obscuresBackgroundDuringPresentation = false
        
        controller.navigationBar.topItem?.hidesSearchBarWhenScrolling = false
        controller.navigationBar.topItem?.searchController = searchController
        
        return controller
        
    }
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
//        Updating Real Time...
        uiViewController.navigationBar.topItem?.title = title
        uiViewController.navigationBar.topItem?.searchController?.searchBar.placeholder = placeHolder
        uiViewController.navigationBar.prefersLargeTitles = largeTitle
    }
    
//    Search Bar Delegate...
    class Coordinator : NSObject,UISearchBarDelegate{
        
        var parent: CustomNavigationViewSearchBarInNavigationBar
        
        init(parent: CustomNavigationViewSearchBarInNavigationBar) {
            self.parent = parent
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//            when text changes...
            self.parent.onSearch(searchText)
        }
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//            when cancel button is clicked..
            self.parent.onCancel()
        }
    }
}

