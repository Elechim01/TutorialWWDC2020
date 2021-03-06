//
//  ScrollableTabBarSwipeableInstagramViewLayout.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 17/12/21.
//

import SwiftUI

struct ScrollableTabBarSwipeableInstagramViewLayout<Content: View>: UIViewRepresentable {
        
    //    to store our swiftUi View...
        var content: Content
        
    //    Gtting Rect To calculate Width And Height Of ScrollView...
        
        var rect: CGRect
        
    //    Contentoffset...
        @Binding var offset: CGFloat
        
    //    Tabs...
        var tabs:[Any]
        
        
        let scrollView = UIScrollView()
        
        init(tabs: [Any],rect: CGRect,offset: Binding<CGFloat>,@ViewBuilder content: ()->Content){
            self.content = content()
            self._offset = offset
            self.rect = rect
            self.tabs = tabs
        }
        
        
        func makeCoordinator() -> Coordinator {
            return ScrollableTabBarScrollableTabBarWithSmoothScrollingTabEffect.Coordinator(parent: self)
        }
       
        
        func makeUIView(context: Context) -> UIScrollView {
            
            setUpScrollView()
    //        setting content Size...
            
            scrollView.contentSize = CGSize(width: rect.width * CGFloat(tabs.count), height: rect.height)
            
            scrollView.contentOffset.x = offset
            
            scrollView.addSubview(extractView())
            
            scrollView.delegate = context.coordinator
            
            return scrollView
        }
        
        func updateUIView(_ uiView: UIScrollView, context: Context) {
    //        Updating View...
            if uiView.contentOffset.x != offset{
            
    //            Animating...
    //            Removing Delegate While Animating...
                uiView.delegate = nil
                
                UIView.animate(withDuration: 0.4) {
                    uiView.contentOffset.x = offset
                }completion: { status in
                    if status{
                        uiView.delegate = context.coordinator
                    }
                }
                
            }
        }
        
    //    setting Up ScrollView...
        func setUpScrollView(){
            scrollView.isPagingEnabled = true
            scrollView.bounces = false
            scrollView.showsVerticalScrollIndicator = false
            scrollView.showsHorizontalScrollIndicator = false
        }
        
    //    Extracting SwiftUi View...
        func extractView() -> UIView {
            
    //        since it depends upon tab size...
    //        so we getting tabs also...
            
            let controller = UIHostingController(rootView: HStack(spacing: 0){content}.ignoresSafeArea())
            controller.view.frame = CGRect(x: 0, y: 0, width: rect.width * CGFloat(tabs.count), height: rect.height)
            
            return controller.view!
        }
        
    //    Delegate function To get Offset...
        class Coordinator: NSObject,UIScrollViewDelegate {
            
            var parent: ScrollableTabBarScrollableTabBarWithSmoothScrollingTabEffect
            
            init(parent:ScrollableTabBarScrollableTabBarWithSmoothScrollingTabEffect){
                self.parent = parent
            }
            
            func scrollViewDidScroll(_ scrollView: UIScrollView) {
                parent.offset = scrollView.contentOffset.x
            }
        }
        
    }

//struct ScrollableTabBarSwipeableInstagramViewLayout_Previews: PreviewProvider {
//    static var previews: some View {
//        ScrollableTabBarSwipeableInstagramViewLayout()
//    }
//}
