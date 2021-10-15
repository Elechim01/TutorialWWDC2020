//
//  ViewSharingImages.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 14/10/21.
//

import SwiftUI

struct ViewSharingImages: View {
    
    @State var items : [Any] = []
    @State var sheet = false
    
    var body: some View {
        VStack{
            Button {
//                adding items to be shared...
                items.removeAll()
                items.append(UIImage(named:"p1")!)
                sheet.toggle()
            } label: {
                Text("Share")
                    .fontWeight(.heavy)
            }
        }
        .sheet(isPresented: $sheet) {
            ShareSheet(items: items)
        }
    }
}

struct ViewSharingImages_Previews: PreviewProvider {
    static var previews: some View {
        ViewSharingImages()
    }
}

//Share Sheet...
struct ShareSheet: UIViewControllerRepresentable  {
    
//   the data you need to share...
    var items : [Any]
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        return controller
    }
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
}
