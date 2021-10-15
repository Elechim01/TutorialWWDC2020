//
//  TutorialWWDC2020App.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 13/09/21.
//

import SwiftUI
import CoreData
import FBSDKCoreKit

@main
struct TutorialWWDC2020App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    ApplicationDelegate.initializeSDK(nil)
                    ApplicationDelegate.shared.application(UIApplication.shared, open: url, sourceApplication: nil, annotation: UIApplication.OpenURLOptionsKey.annotation)
                }
                .environment(\.managedObjectContext, persistentContainer.viewContext)
        }
    }
}

//Core data
var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "CoreData")
    container.loadPersistentStores { storeDescription, eror in
        if let error = eror  as NSError? {
            fatalError("Uresolved error\(error), \(error.userInfo)")
        }
    }
    return container
}()

func savecontext(){
    let contex = persistentContainer.viewContext
    if contex.hasChanges{
        do {
            try contex.save()
        } catch {
            let nserror = error as NSError
            fatalError("Uresolved error\(nserror), \(nserror.userInfo)")
        }
    }
}
