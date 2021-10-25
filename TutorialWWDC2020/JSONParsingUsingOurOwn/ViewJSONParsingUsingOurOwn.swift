//
//  ViewJSONParsingUsingOurOwn.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 25/10/21.
//

import SwiftUI
import SDWebImageSwiftUI
import WebKit

struct ViewJSONParsingUsingOurOwn: View {
    
    @StateObject var data = ModelViewJsonParsing()
    @State var items = Array(repeating: GridItem(spacing: 15), count: 2)
    @State var link = ""
    @State var show = false
    
    var body: some View {
        NavigationView{
            VStack{
                if !data.cards.isEmpty{
                    ScrollView{
                        LazyVGrid(columns: items,spacing: 15) {
                            ForEach(data.cards,id:\.titleName){ card in
                                CardViewJSONParsing(card: card, items: $items)
                                //                            webView...
                                    .onTapGesture {
                                        self.link = card.link
                                        self.show.toggle()
                                    }
                            }
                        }
                        .padding()
                    }
                }else{
                    ProgressView()
                }
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if items.count == 2{
                            items.removeLast()
                        }else{
                            items.append(GridItem(spacing: 15))
                        }
                    } label: {
                        Image(systemName: items.count != 2 ? "square.grid.2x2.fill" : "rectangle.grid.1x2.fill")
                            .font(.system(size:22))
                            .foregroundColor(.white)
                    }
                    
                }
            }
            .sheet(isPresented: $show, content: {
                WebViewJSONParsing(url: $link)
            })
            .preferredColorScheme(.dark)
            .navigationTitle("Kavasoft")
        }
    }
}

//WebView...
struct WebViewJSONParsing: UIViewRepresentable {
    
    @Binding var url :String
    func makeUIView(context: Context) -> WKWebView {
        let view = WKWebView()
        view.load(URLRequest(url: URL(string: url)!))
        
        return view
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
}

struct CardViewJSONParsing : View {
    
    var card : ModelJSOMParsing
    @Binding var items: [GridItem]
    
    var body: some View{
        VStack(spacing: 15){
            WebImage(url: URL(string: card.imageLink)!)
                .resizable()
                .aspectRatio(contentMode: .fit)
            HStack(spacing: 0){
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text(card.titleName)
                        .fontWeight(.bold)
                        .lineLimit(1)
                    
                    Text(card.detail)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(3)
                }
                
                Spacer(minLength: 0)
            }
        }
        .frame(height: items.count == 2 ? (UIScreen.main.bounds.height - 50) / 2.5 : nil)
        .padding()
        .background(Color.primary.opacity(0.05))
        .cornerRadius(10)
    }
}

struct ViewJSONParsingUsingOurOwn_Previews: PreviewProvider {
    static var previews: some View {
        ViewJSONParsingUsingOurOwn()
    }
}

//View Model...
class ModelViewJsonParsing: ObservableObject{
    
    @Published var cards : [ModelJSOMParsing] = []
    
    init(){
        getVideos()
    }
    
    func getVideos(){
        let ulr = "https://kavsoft.dev/api.v1.videos"
        
        var request = URLRequest(url: URL(string: ulr)!)
        
        request.httpMethod = "GET"
        request.addValue("swiftui2.0", forHTTPHeaderField: "field")
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: request) { data, res, err in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            
//            chcking any 404 errors...
            let response = res as! HTTPURLResponse
            
            if response.statusCode == 404{
                print("error 404 = \(String(data: data!, encoding: .utf8) ?? "")")
                return
            }
            do {
                let jsonData = try JSONDecoder().decode([ModelJSOMParsing].self, from: data!)
                DispatchQueue.main.async {
                    self.cards = jsonData
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        .resume()
    }
}

// JSON model...
struct ModelJSOMParsing: Decodable {
    var titleName : String
    var detail: String
    var imageLink: String
    var link: String
}
