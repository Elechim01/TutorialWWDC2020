//
//  ViewApplyingFiltersToImage.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 08/11/21.
//

import SwiftUI

struct ViewApplyingFiltersToImage: View {
    var body: some View {
        NavigationView{
            HomeViewApplyingFiltersToImage()
//            darkMode...
                .navigationTitle("Filter")
                .preferredColorScheme(.dark)
        }
    }
}

struct ViewApplyingFiltersToImage_Previews: PreviewProvider {
    static var previews: some View {
        ViewApplyingFiltersToImage()
    }
}

struct HomeViewApplyingFiltersToImage: View {
    @StateObject var homeData = ViewModelApplyingFiltersToImage()
    var body: some View{
        VStack{
            
            if !homeData.alllImages.isEmpty && homeData.mainView != nil {
                
                Spacer(minLength: 0)
                
                Image(uiImage: homeData.mainView.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width)
                
                Slider(value: $homeData.value)
                    .padding()
                    .opacity(homeData.mainView.isEditable ? 1 : 0)
                    .disabled(homeData.mainView.isEditable ? false : true)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing:20){
                        ForEach(homeData.alllImages){ filtered in
                            Image(uiImage: filtered.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150, height: 150)
//                            Updating MainView...
//                            WhenEver Button Tapped...
                                .onTapGesture {
//                                    clearing old data...
                                    homeData.value = 1.0
                                    homeData.mainView = filtered
                                }
                        }
                    }
                    .padding()
                }
            }
            
            else if homeData.imageData.count == 0{
                Text("Pick An Image To Process !!!")
            }
            else{
//                    Loading View...
                ProgressView()
            }
        }
        .onChange(of: homeData.value, perform: { newValue in
            homeData.updateEffect()
        })
        .onChange(of: homeData.imageData, perform: { newValue in
//            When Ever image is changed firinf loadImage...
            
//            clearing exisint data...
            homeData.alllImages.removeAll()
            homeData.mainView = nil
            homeData.loadFilter()
        })
        .toolbar {
//            image button...
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    homeData.imagePicker.toggle()
                } label: {
                    Image(systemName: "photo")
                        .font(.title2)
                }
            }
            
//            saving image...
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    UIImageWriteToSavedPhotosAlbum(homeData.mainView.image, nil, nil, nil)
                } label: {
                    Image(systemName: "square.and.arrow.up.fill")
                        .font(.title2)
                }
//                disabiling no no Image...
                .disabled(homeData.mainView == nil ? true : false)
            }
        }
        .sheet(isPresented: $homeData.imagePicker) {
            ImagePickerApplyingFiltersToImage(picker: $homeData.imagePicker, imageData: $homeData.imageData)
        }
    }
}
