//
//  ViewRefreshingContentView.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 26/12/21.
//

import SwiftUI

struct ViewRefreshingContentView: View {
    
    var body: some View {
        
        HomeViewRefreshingContentView()
    }
}

struct ViewRefreshingContentView_Previews: PreviewProvider {
    static var previews: some View {
        ViewRefreshingContentView()
    }
}

// Dynamic ScrollView...

struct HomeViewRefreshingContentView: View {
    
    @State var count : Int = 2
    var body: some View{
    
        NavigationView{
            
            RefreshableScrollView(content: {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 3), count: 3),spacing: 3) {
                    
                    ForEach(1..<count,id:\.self){ index in
                        
                        GeometryReader{ proxy in
                            
                            let width = proxy.frame(in: .global).width
                            
                            Image("r\(index)")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: width, height: 183)
                                .cornerRadius(1)
                        }
                        .frame(height: 183)
                    }
                }
                .padding()
                
            }, onRefresh: {control in
//                Refresh Content..
//                Do what ever Update...
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.count += 3
                    control.endRefreshing()
                }
//                Ending Refresh..
                
            })
            .navigationTitle("Pull Me Down")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

//Custom scrollView Wirh Refresh Contro..
struct RefreshableScrollView<Content: View>: UIViewRepresentable {
    
    var content: Content
    var onRefresh: (UIRefreshControl)->()
    var refreshControl = UIRefreshControl()
    
//    View Builder to capture SwiftUI View...
    init(@ViewBuilder content: @escaping ()->Content,onRefresh: @escaping (UIRefreshControl)->()){
        self.content = content()
        self.onRefresh = onRefresh
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UIScrollView {
    
        let uiscrollView = UIScrollView()
        
//        Refresh control...
        refreshControl.attributedTitle = NSAttributedString(string: "Pull Me")
        refreshControl.tintColor = .red
        refreshControl.addTarget(context.coordinator, action: #selector(context.coordinator.onRefresh), for: .valueChanged)
        
//        Since were removing the last subview...
//        so it will remove refresh controll
//        so add after setting up view...
        
        setUpView(uiscrollView: uiscrollView)
        
        uiscrollView.refreshControl = refreshControl

        return uiscrollView
        
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        
//        Because view is not updating dynamically....
//        Updating View Dynamically...
        
        setUpView(uiscrollView: uiView)
        
    }
    
    func setUpView(uiscrollView: UIScrollView){
        //        Extracting SwiftUi View...
        //        Moving View Up....
        
        let hostView = UIHostingController(rootView: content.frame(maxHeight: .infinity, alignment: .top))
        
        //        Were going to constraints System from UIKit...
        //        so that no need of width and height calculations...
        hostView.view.translatesAutoresizingMaskIntoConstraints = false
        
        //        Cliping the swiftUi view to UIKit View...
        let constraints = [
            
            //            Four Corners..
            hostView.view.topAnchor.constraint(equalTo: uiscrollView.topAnchor),
            hostView.view.bottomAnchor.constraint(equalTo: uiscrollView.bottomAnchor),
            hostView.view.leadingAnchor.constraint(equalTo: uiscrollView.leadingAnchor),
            hostView.view.trailingAnchor.constraint(equalTo: uiscrollView.trailingAnchor),
            
            //            Size...
            hostView.view.widthAnchor.constraint(equalTo: uiscrollView.widthAnchor),
            //            Four Bouncing...
            hostView.view.heightAnchor.constraint(greaterThanOrEqualTo: uiscrollView.heightAnchor,constant: 1),
            
        ]
//        Removing Previously Added View...
        uiscrollView.subviews.last?.removeFromSuperview()
        uiscrollView.addSubview(hostView.view)
        uiscrollView.addConstraints(constraints)
    }
    
    class Coordinator: NSObject {
        
        var parent: RefreshableScrollView
        
        init(parent: RefreshableScrollView){
            self.parent = parent
        }
        
        @objc func onRefresh(){
            parent.onRefresh(parent.refreshControl)
        }
    }
}
