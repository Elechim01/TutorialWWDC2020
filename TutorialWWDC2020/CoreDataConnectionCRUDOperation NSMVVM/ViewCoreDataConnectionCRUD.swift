//
//  ViewCoreDataConnectionCRUD.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 05/10/21.
//

import SwiftUI
import CoreData

struct ViewCoreDataConnectionCRUD: View {
    @StateObject var model = dataModel()
    var body: some View{
        NavigationView{
            VStack{
                List{
                    ForEach(model.data,id: \.objectID){ obj in
                        //                extracting data from object...
                        
                        Text(model.getValue(obj: obj))
                            .onTapGesture {
                                model.openUpdateView(obj: obj)
                            }
                    }
                    .onDelete(perform: model.deleteData(indexSet:))
                }
                .listStyle(InsetGroupedListStyle())
                HStack(spacing: 15){
                    TextField("Data Here", text: $model.txt)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button {
                        model.writeData()
                    } label: {
                        Text("Save")
                    }
                }
                .padding()
            }
            .sheet(isPresented: $model.isUpdate, content: {
//                Update View...
                UpdateView(model: model)
            })
            .navigationTitle("Core Data")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
struct UpdateView : View {
    @ObservedObject var model : dataModel
    var body: some View{
        VStack(spacing: 20){
            TextField("Update Here",text: $model.updateTxt)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button {
                model.updateData()
            } label: {
                Text("Update")
            }
        }
        .padding()
    }
}

struct ViewCoreDataConnectionCRUD_Previews: PreviewProvider {
    static var previews: some View {
        ViewCoreDataConnectionCRUD()
    }
}

//MVVM Pattern...
class dataModel : ObservableObject {
    @Published var data : [NSManagedObject] = []
    @Published var txt = ""
    @Published var isUpdate = false
    @Published var updateTxt = ""
    @Published var selectedObj = NSManagedObject()
    let context = persistentContainer.viewContext
    
    init(){
        readData()
    }
    
    func readData(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CData")
        do {
            let results = try context.fetch(request)
            self.data = results as! [NSManagedObject]
        } catch {
            print(error.localizedDescription)
        }
    }
    func writeData(){
//        Writing Data...
        let entity = NSEntityDescription.insertNewObject(forEntityName: "CData", into: context)
        entity.setValue(txt, forKey: "value")
        do {
            try context.save()
//            if succes menas append data to list...
            self.data.append(entity)
//            clearing data...
            txt = ""
        } catch{
            print(error.localizedDescription)
        }
    }
    func deleteData(indexSet : IndexSet){
//        seleting data...
        for index in indexSet {
            do {
                
                let obj = data[index]
                context.delete(obj)
                try context.save()
//                if succes means removing data from list....
                let index = data.firstIndex(of: obj)
                data.remove(at: index!)
            } catch {
                print(error.localizedDescription)
            }
        }
       
    }
    func updateData(){
//        Updating And Closing View...
//        finding index...
        let index = data.firstIndex(of: selectedObj)
//        fetching and updating data...
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CData")
        do {
          let results = try context.fetch(request) as! [NSManagedObject]
//            updating data...
           let obj =  results.first { obj -> Bool in
                if obj == selectedObj{return true}
                else{return false}
            }
            obj?.setValue(updateTxt, forKey: "value")
//            saving...
            try context.save()
//            if success means update and close the view...
            data[index!] = obj!
            isUpdate.toggle()
            updateTxt = ""
            
        } catch {
            print(error.localizedDescription)
        }
    }
    func getValue(obj: NSManagedObject) -> String {
        return obj.value(forKey: "value") as! String
    }
    
    func openUpdateView(obj: NSManagedObject){
        selectedObj = obj
        isUpdate.toggle()
    }
}
