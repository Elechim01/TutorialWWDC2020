//
//  TutorialWWDC2020App.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 13/09/21.
//

import SwiftUI
import CoreData
import FBSDKCoreKit
import Firebase
import StreamChat
import JWTKit

@main
struct TutorialWWDC2020App: App {
    @UIApplicationDelegateAdaptor(Delegate.self) var delegate
//            Usato per ParsingJSONAndStoringToCoreData
    let persistenceJSON = PersistenceJSON.shared
    var body: some Scene {
        
        WindowGroup {
            ContentView()
//            SCOMMENTARE ANCHE QUESTO PER CoreDataConnectionCRUDOperation
//                .environment(\.managedObjectContext, persistentContainer.viewContext)
//            Usato per ParsingJSONAndStoringToCoreData
                .environment(\.managedObjectContext, persistenceJSON.container.viewContext)
        }
    }
}

class Delegate: NSObject,UIApplicationDelegate {
    
//    different way of intualizing the Stream..
    
    @AppStorage("userName") var storedUser = ""
    @AppStorage("log_Status") var logStatus = false
    
    
    func application(
            _ application: UIApplication,
            didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
        ) -> Bool {
              
            ApplicationDelegate.shared.application(
                application,
                didFinishLaunchingWithOptions: launchOptions
            )
            FirebaseApp.configure()
            
            let config = ChatClientConfig(apiKeyString: APIKeyChatAppUsingStreamSDK)
            
//            if user already logged in...
            if logStatus{
                
//                Da Scommentare per app che richiedono StramChat
//                ChatClient.shared = ChatClient(config: config, tokenProvider: .development(userId: storedUser))
                
                //            for that we need to intialize the stream sdk with JWT Tokens...
                //            AKA Known as Authentiactiog with stream SDK...
                            
                //            generating JWT token...
                            
                            let signers = JWTSigners()
                            signers.use(.hs256(key: SecretKeyFirebasePhoneAuthFirebaseStreamSDK.data(using: .utf8)!))
                            
                //            Creatng Payload and inserting Userd ID to generate token...
                //            Here User ID will be Firebase UID...
                //            Since its Unique...
                            
                            guard let uid = Auth.auth().currentUser?.uid else {
            
                                return true
                            }
                            
                            let payload = PayLoadFirebasePhoneAuthFirebaseStreamSDK(user_id: uid)
                            
                //            generating Token...
                            do{
                                
                                let jwt = try signers.sign(payload)
                                
                                print(jwt)
                                
                                let config = ChatClientConfig(apiKeyString: APIKeyFirebasePhoneAuthFirebaseStreamSDK)
                                
//                                let tokenProvider = TokenProvider{ client, _ in
//
//                                    guard let token = try? Token(rawValue: jwt) else {
//                                        return
//                                    }
//
//                                    completion(.success(token))
//                                }
//
//                                ChatClient.shared = ChatClient(config: config, tokenProvider: tokenProvider)
                                
                            }
                            catch{
                                print(error.localizedDescription)
                            }
                
            }else{
                
//                ChatClient.shared = ChatClient(config: config, tokenProvider: .anonymous)
                
            }
            
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
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
    }
    
    }

//Parte per ChatAppUsingStreamSDK
// stram API...
extension ChatClient{
    static var shared: ChatClient!
}




//PARTE DI CORE DATACoreDataConnectionCRUDOperation
//Core data da scommentare se si vuole provare il  NSMVVM

//var persistentContainer: NSPersistentContainer = {
//    let container = NSPersistentContainer(name: "CoreData")
//    container.loadPersistentStores { storeDescription, eror in
//        if let error = eror  as NSError? {
//            fatalError("Uresolved error\(error), \(error.userInfo)")
//        }
//    }
//    return container
//}()
//
//func savecontext(){
//    let contex = persistentContainer.viewContext
//    if contex.hasChanges{
//        do {
//            try contex.save()
//        } catch {
//            let nserror = error as NSError
//            fatalError("Uresolved error\(nserror), \(nserror.userInfo)")
//        }
//    }
//}


