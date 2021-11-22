//
//  ViewNotificationsWithCategoryActions.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 22/11/21.
//

import SwiftUI
import UserNotifications

struct ViewNotificationsWithCategoryActions: View {
    var body: some View {
        HomeViewNotificationsWithCategoryActions()
    }
}

struct ViewNotificationsWithCategoryActions_Previews: PreviewProvider {
    static var previews: some View {
        ViewNotificationsWithCategoryActions()
    }
}

struct HomeViewNotificationsWithCategoryActions: View {
    
    @StateObject var delegate = NotificationDelegate()
    
    var body: some View{
        Button {
            createNotification()
        } label: {
            Text("Notify User")
        }
        .onAppear {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { _, _ in
                
            }
            
            UNUserNotificationCenter.current().delegate = delegate
        }
        .alert(isPresented: $delegate.alert) {
            Alert(title: Text("Message"), message: Text("Reply Button Is Pressed !!!"), dismissButton: .destructive(Text("OK")))
        }
    }
    
    func createNotification(){
        let content = UNMutableNotificationContent()
        content.title = "Message"
        content.subtitle = "Notification From In-App Form Michele"
//        Assignig to our notification...
        content.categoryIdentifier = "ACTIONS"
        
//
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "IN-APP", content: content, trigger: trigger)
        
//        actions...
        let close = UNNotificationAction(identifier: "CLOSE", title: "Close", options: .destructive)
        let reply = UNNotificationAction(identifier: "REPLY", title: "Reply", options: .foreground)
        
        let category = UNNotificationCategory(identifier: "ACTIONS", actions: [close,reply], intentIdentifiers: [], options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}

//For inApp Notification...

class NotificationDelegate: NSObject,ObservableObject,UNUserNotificationCenterDelegate {
    
    @Published var alert = false
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge,.banner,.sound])
    }
    
//    listening to actions...
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if response.actionIdentifier == "REPLY"{
            print("reply the comment or do anything....")
            self.alert.toggle()
        }
        completionHandler()
    }
}

// creating Notifications....


// getting access for notifications....
