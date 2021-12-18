//
//  CustomCameraSwipeableInstagramViewLayout.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 17/12/21.
//

import SwiftUI
import Foundation
import AVFoundation

struct CustomCameraSwipeableInstagramViewLayout: View {
    @StateObject var camera = CameraModel()
    @Binding var offset: CGFloat
    var body: some View {
        ZStack{
//            sta per essere la cmaera view
            CameraPreview(camera: camera)
                .ignoresSafeArea(.all,edges: .all)
            
            VStack{
                Spacer()
                HStack{
                    
                    if camera.isTaken{
                        Button(action: {
                            camera.reTake()
                        }, label: {
                            Image(systemName: "arrow.triangle.2.circlepath.camera")
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                        })
                        
                    }else{
                            Button(action: {
                                camera.takePic()
                            }, label: {
                            ZStack{
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 65, height: 65)
                                Circle()
                                    .stroke(Color.white,lineWidth: 2)
                                    .frame(width: 75, height: 75)
                            }
                        })
                    }
                }
                .frame(height: 75)
                .padding(.bottom,edgesSwipeableInstagramViewLayout?.bottom ?? 15)
            }
        }
        .onAppear{
            camera.Check()
        }
        .onChange(of: offset) { value in
            if value == 0 && !camera.session.isRunning{
                camera.session.stopRunning()
            }else{
                if camera.session.isRunning{
                    camera.session.stopRunning()
                }
            }
        }
    }
}

class CameraModel: NSObject,ObservableObject,AVCapturePhotoCaptureDelegate {
    @Published var isTaken = false
    @Published var session = AVCaptureSession()
    @Published var alert : Bool = false
//    since were going to read pic data...
    @Published var output = AVCapturePhotoOutput()
//    preview
    @Published var preview : AVCaptureVideoPreviewLayer!
//    Pic Data
    @Published var isSaved = false
    @Published var picData = Data(count: 0)
    
    func Check() {
//        controllo se la camera ha i permessi
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
//            settings up session
            SetUp()
            return
        case .notDetermined:
//            retusting for permission....
            AVCaptureDevice.requestAccess(for: .video) { (status) in
                if status{
                    self.SetUp()
                }
            }
        case .denied:
            self.alert.toggle()
            return
        default:
            return
        }
    }
    func SetUp() {
//        setting up camera
        do {
//            setting configurazione
            self.session.beginConfiguration()
//            Change for your own
            let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
            let input = try AVCaptureDeviceInput(device: device!)
//            controllo aggiunta ala sessione
            if self.session.canAddInput(input){
                self.session.addInput(input)
            }
//            Same for output
            if self.session.canAddOutput(self.output){
                self.session.addOutput(self.output)
            }
            self.session.commitConfiguration()
            
        } catch  {
            print(error.localizedDescription)
        }
    }
//    Take and retake functions
    func takePic() {
        DispatchQueue.global(qos: .background).async {
            self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
            self.session.stopRunning()
            DispatchQueue.main.async {
                withAnimation{
                    self.isTaken.toggle()
                }
            }
        }
    }
    func reTake(){
        DispatchQueue.global(qos: .background).async {
            self.session.startRunning()
            DispatchQueue.main.async {
                withAnimation{
                    self.isTaken.toggle()
                }
//                pulizia
                self.isSaved = false
            }
        }
    }
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if error != nil{
            return
        }
        print("pic taken...")
        guard let imageData = photo.fileDataRepresentation() else {
            return
        }
        self.picData = imageData
        
    }
    
//    func savePic(){
//        let image = UIImage(data: self.picData)!
////        Salvataggio immagine
//        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
//        self.isSaved = true
//        print("saved Succesfully......")
//    }
    
}
//Setting view for preview
struct CameraPreview : UIViewRepresentable {
    @ObservedObject var camera : CameraModel
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
        camera.preview.frame = view.frame
        
//        Your Own Properties
        camera.preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(camera.preview)
        
   
        return view
    }
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}


//struct CustomCameraSwipeableInstagramViewLayout_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomCameraSwipeableInstagramViewLayout()
//    }
//}
