//
//  ViewRestfullApiSailsjs.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 19/10/21.
//
// Per vedere la parte del web service:
// /Users/michelemanniello/Documents/Sviluppo/Server
import SwiftUI

struct ViewRestfullApiSailsjs: View {
    @StateObject var data = Server()
    var body: some View {
        NavigationView{
            VStack{
                if data.users.isEmpty{
                    if data.noData{
                        Text("No User Found ")
                    }
                    else{
                        ProgressView()
                    }
                }else{
                    List{
                        ForEach(data.users,id: \.id){ user in
                            VStack(alignment: .leading, spacing: 10) {
                                Text(user.username)
                                    .fontWeight(.bold)
                                
                                Text(user.password)
                                    .font(.caption)
                            }
                        }
                        .onDelete { indexset in
                            indexset.forEach { index in
                                data.deleteusers(id: data.users[index].id)
                            }
                        }
                    }
                }
                
            }
            //        .navigationbar items is decreèted...
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: data.newValue) {
                        Text("Create")
                    }
                }
            }
            .navigationTitle("Sails JS")
        }
    }
}

struct ViewRestfullApiSailsjs_Previews: PreviewProvider {
    static var previews: some View {
        ViewRestfullApiSailsjs()
    }
}

class Server: ObservableObject {
    @Published var users : [User] = []
    let url = "http://localhost:1337/user"
    @Published var noData = false
    init(){
        getUsers()
    }
    
    func setUser(username: String,password: String){
        let session = URLSession(configuration: .default)
        var reqest = URLRequest(url: URL(string: url)!)
        reqest.httpMethod = "POST"
        reqest.addValue(username, forHTTPHeaderField: "username")
        reqest.addValue(password, forHTTPHeaderField: "password")
        session.dataTask(with: reqest) { data, _, err in
            if err != nil{
                print(err!.localizedDescription)
                return
            }
            guard let response = data else {return}
            
            let status = String(data: response, encoding: .utf8) ?? ""
            print(status)
            if status == "PASS"{
                self.getUsers()
            }else{
                print("Fallied To Write..")
            }
        }.resume()
    }
    func getUsers(){
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        session.dataTask(with: request) { data, _, err in
            if err != nil{
                print(err!.localizedDescription)
                self.noData.toggle()
                return
            }
            
            guard let response = data else {return}
            
            let users = try! JSONDecoder().decode([User].self, from: response)
            
            DispatchQueue.main.async {
                self.users = users
                if users.isEmpty{self.noData.toggle()}
            }
        }.resume()
    }
    func deleteusers(id: Int){
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "DELETE"
        
//        if simply destroy menad it will delete all data...
        request.addValue("\(id)", forHTTPHeaderField: "id")
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: request) { data, _, err in
            if err != nil{
                print(err!.localizedDescription)
                return
            }
            
            guard let response = data else {return}
            
            let status = String(data: response, encoding: .utf8) ?? ""
            if status == "PASS"{
                DispatchQueue.main.async {
//                    removing data in Lists..
                    self.users.removeAll { user in
                        return user.id == id
                    }
                }
            }else{
                print("Failed To Delete")
            }
            
        }.resume()
    }
    func newValue(){
//        Aler View...
        let alert = UIAlertController(title: "New User", message: "Create A Account", preferredStyle: .alert)
        alert.addTextField { user in
            user.placeholder = "Username"
        }
        alert.addTextField { pass in
            pass.placeholder = "Password"
            pass.isSecureTextEntry = true
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        alert.addAction(UIAlertAction(title: "Create", style: .default, handler: { _ in
            self.setUser(username: alert.textFields![0].text!, password: alert.textFields![1].text!)
        }))
//        Presenting..
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
    }
}
//Model...
struct User: Decodable {
    
//    it will be automatically created....
    var id : Int
    var username: String
    var password : String
    
}

//Going to create New Sail JS App...
//Created Successfully...
//Going to create Route For /users...
