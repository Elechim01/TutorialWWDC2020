//
//  DownloadTaskModelSessionDownloadTask.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 23/12/21.
//

import SwiftUI

class DownloadTaskModelSessionDownloadTask: NSObject,ObservableObject,URLSessionDownloadDelegate,UIDocumentInteractionControllerDelegate {
    
    
    
    @Published var downloadURL: URL!
    
//    Alert..
    @Published var alertMsg = ""
    @Published var showAlert = false
    
//    Saving Download task reference for canelling...
    @Published var downloadtaskSession: URLSessionDownloadTask!
    
//    Progress...
    @Published var downloadProgress: CGFloat = 0
    
//    show progress View...
    @Published var showDownloadProgess = false
    
//    Download Function..
    func startDownload(urlString: String){
        
//        checking for valid URL
        guard let ValidURl = URL(string: urlString) else {
            self.reportError(error: "Invalid URL !!")
            return
        }
        
//        preventing downloading the same file again..
        
        let directoryPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        if FileManager.default.fileExists(atPath: directoryPath.appendingPathComponent(ValidURl.lastPathComponent).path){
            
            print("yes file found")
            let controller = UIDocumentInteractionController(url: directoryPath.appendingPathComponent(ValidURl.lastPathComponent))
            
//                it needs a delegate....
            controller.delegate = self
            controller.presentPreview(animated: true)
        }else{
            print("no file found")
            //        valid URL...
                    downloadProgress = 0
                    withAnimation {
                        showDownloadProgess = true
                    }
                    
            //        Download task...
            //        since were going the progress as well as location of title so were using delegate...
                    let session = URLSession(configuration: .default,delegate: self, delegateQueue: nil)
                    
                    downloadtaskSession = session.downloadTask(with: ValidURl)
                    downloadtaskSession.resume()
        }

    }
    
//    error
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        
        DispatchQueue.main.async {
            if let error = error {
                withAnimation{self.showDownloadProgess = false}
                self.reportError(error: error.localizedDescription)
                return
            }
        }
    }
    
//    Report Error function...
    func reportError(error: String){
        self.alertMsg = error
        showAlert.toggle()
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {

//        since it will download it as temporay data..
//        so were going save it in app document directory and showing it in document controller..
        
        guard let url = downloadTask.originalRequest?.url else {
            
            DispatchQueue.main.async {
                self.reportError(error: "Something went wrong pleade try again later")
            }
            return
        }
        
//        directory Path...
        downloadProgress = 0
        let directoryPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
//        creating one for storing File..
//        destination URL
//        getting like..
        let destinationURL = directoryPath.appendingPathComponent(url.lastPathComponent)
        
//        if already file is there removing that...
        try? FileManager.default.removeItem(at: destinationURL)
        
        do{
            
//            copying temp to directory..
            try FileManager.default.copyItem(at: location, to: destinationURL)
            
//            if success
            print("success")
//            closing progess view...
            DispatchQueue.main.async {
                withAnimation {
                    self.showDownloadProgess = false
                }
//                presenting the file with the help of document interaction controller from UIKit
                
                let controller = UIDocumentInteractionController(url: destinationURL)
                
//                it needs a delegate....
                controller.delegate = self
                controller.presentPreview(animated: true)
            }
            
        }catch{
            DispatchQueue.main.async {
                self.reportError(error: "Please try againg later!!")
            }
        }
        
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
//        progress..
        let progres = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)
        
//        since url session will be running in BG Thread...
//        so UI updates will be done in main threads...
        DispatchQueue.main.async {
            self.downloadProgress = progres
        }
    }
    
//    cancel Task...
    func cancelTask(){
        if let task = downloadtaskSession,task.state == .running{
//            cancelling...
            downloadtaskSession.cancel()
//            closing view...
            withAnimation {
                self.showDownloadProgess = false
            }
        }
    }
    
//    Sub Functions for presenting view...
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return UIApplication.shared.windows.first!.rootViewController!
    }
}

