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
    @UIApplicationDelegateAdaptor(Delegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistentContainer.viewContext)
        }
    }
}

class Delegate: NSObject,UIApplicationDelegate {
    func application(
            _ application: UIApplication,
            didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
        ) -> Bool {
              
            ApplicationDelegate.shared.application(
                application,
                didFinishLaunchingWithOptions: launchOptions
            )

            return true
        }
              
        func application(
            _ app: UIApplication,
            open url: URL,
            options: [UIApplication.OpenURLOptionsKey : Any] = [:]
        ) -> Bool {

            ApplicationDelegate.shared.application(
                app,
                open: url,
                sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                annotation: options[UIApplication.OpenURLOptionsKey.annotation]
            )
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
