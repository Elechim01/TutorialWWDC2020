//
//  ImageViewModelCustomImageVideoPicker.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 18/12/21.
//

import SwiftUI
import Photos
import AVKit

class ImageViewModelCustomImageVideoPicker: NSObject,ObservableObject, PHPhotoLibraryChangeObserver {
   
    @Published var showImagePicker = false
    
    @Published var library_status = LibraryStatusCustomImageVideoPicker.denied
    
//    List Of Fetched Photos...
    @Published var fetchedPhotos : [AssetCustomImageVideoPicker] = []
    
//    To Get Updates...
    @Published var allPhotos : PHFetchResult<PHAsset>!
    
//    preview...
    @Published var showPreview = false
    @Published var selectedImagePreview: UIImage!
    @Published var selectedVideoPreview: AVAsset!
    
    func openImagePicker(){
        
//        Closing Keyboard if opened...
        
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        
//        Fetching Images When it Needed...
        if fetchedPhotos.isEmpty{
            fetchPhotos()
        }
        
        
        withAnimation {
            showImagePicker.toggle()

        }
    }
    
    func setUp(){
//        request Permission...
        PHPhotoLibrary.requestAuthorization(for: .readWrite) {[self] status in
            
            DispatchQueue.main.async {
                switch status{
                    case .denied: library_status = .denied
                    case .authorized: library_status = .approved
                    case .limited: library_status = .limited
                    default: library_status = .denied
                    
                }
            }
        }
        
//        Registering Observer...
        PHPhotoLibrary.shared().register(self)
        
    }
    
//    Lidtening To Changes...
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let _ = allPhotos else { return }
        
        if let updates = changeInstance.changeDetails(for: allPhotos){
            
//            Getting Updated List...
            let updatedPhotos = updates.fetchResultAfterChanges
            
//            there is bug in it...
//            It is not updating the inserted or removed items...
            
//            print(updates.insertedObjects.count)
//            print(updates.removedObjects.count)
            
//            So were Going to verify All And Append Only No in the list....
//            To Avoid Of reloading all and ram usage..
            
            updatedPhotos.enumerateObjects {[self] asset, index, _ in
                
                if !allPhotos.contains(asset){
                    
//                    if its not There...
//                    getting Image And Appending it to array...
                    
                    getImageFromAsset(asset: asset,size: CGSize(width: 150, height: 150)) { image in
                        DispatchQueue.main.async {
                            fetchedPhotos.append(AssetCustomImageVideoPicker(asset: asset, image: image))
                        }
                    }
                    
                }
            }
            
//            To Remove If Image is removed...
            allPhotos.enumerateObjects { asset, index, _ in
                
                if !updatedPhotos.contains(asset){

//                    removing it...
                    DispatchQueue.main.async {
                        self.fetchedPhotos.removeAll { result in
                            return result.asset == asset
                        }
                    }
                }
            }
            
            DispatchQueue.main.async {
                self.allPhotos = updatedPhotos
            }
            
        }
    }
    
    
    func fetchPhotos(){
//        Fetching All Photos..
        
        let options = PHFetchOptions()
        options.sortDescriptors = [
            NSSortDescriptor(key: "creationDate", ascending: false)
        ]
        options.includeHiddenAssets = false
        
       let fetchResults =  PHAsset.fetchAssets(with: options)
        
        allPhotos = fetchResults
        
        fetchResults.enumerateObjects { [self] asset, index, _ in
//            Getting Image From Asset...
            
            getImageFromAsset(asset: asset,size: CGSize(width: 150, height: 150)) { image  in
//                Appending it To Array...
                
//                Why we storing asset..
//                to get full image for sending..
                
                fetchedPhotos.append(AssetCustomImageVideoPicker(asset: asset, image: image))
            }
        }
    }
    
//    Using Completion Handlers...
//    To recive Objects..
    func getImageFromAsset(asset: PHAsset,size: CGSize,completion: @escaping (UIImage) -> ()){
        
//        To cache image in memory...
        
        let imageManager = PHCachingImageManager()
        imageManager.allowsCachingHighQualityImages = true
        
        let imageOptions = PHImageRequestOptions()
        imageOptions.deliveryMode = .highQualityFormat
        imageOptions.isSynchronous = false
        
//        To reduce Ram Usage just getting Thumbnail Size of image..
        
        let size = CGSize(width: 150, height: 150)
        
        imageManager.requestImage(for: asset, targetSize: size, contentMode: .aspectFit, options: imageOptions) { image, _ in
            guard let resizedImage = image else { return  }
            
            completion(resizedImage)
        }
    }
    
//    Opening Image Or video...
    func extractPreviewData(asset: PHAsset){
        
        let manager = PHCachingImageManager()
        
        if asset.mediaType == .image{
//                Extract Image...
            getImageFromAsset(asset: asset, size: PHImageManagerMaximumSize) { image in
                DispatchQueue.main.async {
                    self.selectedImagePreview = image
                }
            }
        }
        
        if asset.mediaType == .video{
            
//            Extract Video...
            let videoManager = PHVideoRequestOptions()
            videoManager.deliveryMode = .highQualityFormat
            
            manager.requestAVAsset(forVideo: asset, options: videoManager) { videoAsset, _, _ in
                
                guard let videoUrl = videoAsset else { return  }
                
                DispatchQueue.main.async {
                    self.selectedVideoPreview = videoUrl
                }
            }
            
        }
        
    }
    
}

