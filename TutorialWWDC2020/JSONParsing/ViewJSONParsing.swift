//
//  ViewJSONParsing.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 03/10/21.
//
// JSON : https://api.github.com/users
import SwiftUI
import SDWebImageSwiftUI

struct ViewJSONParsing: View {
    var body: some View {
        NavigationView{
            HomeJSON()
                .navigationTitle("GitHub Users")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ViewJSONParsing_Previews: PreviewProvider {
    static var previews: some View {
        ViewJSONParsing()
    }
}
struct HomeJSON: View {
    @State var users : [JSONData] = []
    var body: some View{
        VStack{
            if users.isEmpty{
//                loading View...
                Spacer()
                ProgressView()
                Spacer()
            }else{
//               displaying users...
                List(users){ user in
                    NavigationLink {
                        DetailView(user: user)
                    } label: {
                        RowView(user: user)
                    }

                }
                .listStyle(InsetGroupedListStyle())
            }
        }
//        refresh Button...
        .toolbar(content: {
            Button {
                users.removeAll()
                getUserData(url: "https://api.github.com/users") { users in
                    self.users = users
                }
            } label: {
                Image(systemName: "arrow.clockwise")
            }

        })
        .onAppear {
//            loading users data..
            getUserData(url: "https://api.github.com/users") { users in
                self.users = users
            }
        }
    }
}

//User View...
struct RowView : View {
    var user : JSONData
    var body: some View{
        HStack(spacing: 15){
            AnimatedImage(url: URL(string: user.avatar_url)!)
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .shadow(radius: 5)
            
            Text(user.login)
                .fontWeight(.bold)
                .foregroundColor(.black)
        }
        .padding(.vertical,4)
    }
}

//Detail View..
struct DetailView: View {
    var user: JSONData
    @State var followers : [JSONData] = []
    @State var isEmpty = false
    var body: some View{
        
        VStack{
            if followers.isEmpty{
                Spacer()
                if isEmpty{
                    Text("No Followers")
                        .fontWeight(.bold)
                }else{
                    ProgressView()
                }
                Spacer()
            }else{
                List{
//                    initial followers Text...
                    Text("Followers")
                    
                    
                    ForEach(followers){ user in
                        RowView(user: user)
                    }
                    .listStyle(InsetGroupedListStyle())
                }
            }
        }
//        settings user name as Nav title
        .navigationTitle(user.login)
        .onAppear {
//            loading user followers data...
            getUserData(url: user.followers_url) { followers in
                
                if followers.isEmpty{
                    isEmpty = true
                }else{
                    self.followers = followers
                }
               
            }
        }
    }
}

//Model...
struct JSONData : Identifiable,Decodable {
    
    var id: Int
    var login : String
    var avatar_url : String
    var followers_url: String
}
// completion Handler For JSON Data...
//returnign array of user data...
func getUserData(url: String,completion: @escaping ([JSONData]) -> ()){
    let session = URLSession(configuration: .default)
    session.dataTask(with: URL(string: url)!) { data, _, err in
        if err != nil{
            print(err!.localizedDescription)
            return
        }
        
//        decoding JSON...
        do{
            let users = try JSONDecoder().decode([JSONData].self, from: data!)
            
//            returning users...
            completion(users)
        }catch{
            print(error)
        }
    }
    .resume()
}
