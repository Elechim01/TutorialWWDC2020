//
//  ProfileDetailViewComplexHeroAnimations.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 22/12/21.
//

import SwiftUI

struct ProfileDetailViewComplexHeroAnimations: View {
    
    var animation: Namespace.ID
    @EnvironmentObject var profileData: ProfileDetailModelComplexHeroAnimations
    @GestureState var offset: CGFloat = 0
    
    var body: some View {
        
//        Since we clearing the data...
        ZStack(alignment: .top){
            if profileData.selectedProfile != nil{
                
                if profileData.showEnlargedImage{
                    
                    Image(profileData.selectedProfile.profile)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: profileData.selectedProfile.id, in: animation)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
    //                Gesture Offset...
                        .offset(y: profileData.offset)
    //                Since on Changed on Gesture is not working properly...
    //                so we re using updating Method...
                        .gesture(DragGesture().updating($offset, body: { value, out, _ in
                            out = value.translation.height
                        }).onEnded({ value in
                            let offset = profileData.offset > 0 ? profileData.offset : -profileData.offset
                            
                            withAnimation {
                                if offset > 200{
                                    
                                    profileData.showProfile.toggle()
                                    profileData.showEnlargedImage.toggle()
                                    profileData.selectedProfile = nil
                                    
                                }
                                profileData.offset = 0
                            }
                            
                        }))
                        .background(Color.blue.opacity(getOpacity()).ignoresSafeArea())
                    
    //                top Action Area...
                    HStack(spacing: 20){
                        Button {
    //                        closing view...
                            withAnimation {
                                profileData.showEnlargedImage.toggle()
                                profileData.showProfile.toggle()
                                profileData.selectedProfile = nil
                            }
                        } label: {
                            Image(systemName: "arrow.left")
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                        
                        Text(profileData.selectedProfile.userName)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
    //                    Matched Geometry Effect...
                            .matchedGeometryEffect(id: "TEXT_\(profileData.selectedProfile.id)", in: animation)
                        
                        Spacer()
                    }
                    .padding()
                    
                }else{
                    
        //          Making it as button to enlarge gib Image..
                    Button(action: {
                        
    //                    Triggering Enlrage Image...
                        withAnimation(.easeInOut){
                            profileData.showEnlargedImage.toggle()
                        }
                        
                    }, label: {
                        Image(profileData.selectedProfile.profile)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .overlay(TitleViewComplexHeroAnimations(recent: profileData.selectedProfile, animation: animation),alignment: .top)
                    })
                    
                        .overlay(BottomActionsComplexHeroAnimations().offset(y: 50),alignment: .bottom)
                        .matchedGeometryEffect(id: profileData.selectedProfile.id, in: animation)
                        .frame(width: 300, height: 300)
                    //        Background Color...
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(
                            Color.blue
                                .opacity(0.2)
                                .ignoresSafeArea()
                            //                closing when tapping on background..
                                .onTapGesture {
                                    withAnimation {
                                        profileData.showProfile.toggle()
                                        profileData.selectedProfile = nil
                                    }
                                }
                        )
                }
                
            }
        }
        .onChange(of: offset) { newValue in
            profileData.offset = offset
        }
    }
    
    func getOpacity() -> Double {
        let offset = profileData.offset > 0 ? profileData.offset : -profileData.offset
        
//        max is 200
//        its your wish...
        let progress = offset / 200
        
        return 1 - Double(progress)
    }
    
}

struct ProfileDetailViewComplexHeroAnimations_Previews: PreviewProvider {
    static var previews: some View {
        ViewComplexHeroAnimations()
    }
}

struct TitleViewComplexHeroAnimations: View{
    
    var recent: ProfileComplexHeroAnimations
    var animation: Namespace.ID
    
    var body: some View{
        
        Text(recent.userName)
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .matchedGeometryEffect(id: "TEXT_\(recent.id)", in: animation)
            .frame(maxWidth: .infinity, alignment: .leading)
            .lineLimit(1)
            .padding(.vertical,10)
            .padding(.horizontal)
            .background(Color.blue.opacity(0.35))
    }
}

//Bottom Actions..
struct BottomActionsComplexHeroAnimations:View {
    
    var body: some View{
        HStack{
            
            Button {
                
            } label: {
                Image(systemName: "message.fill")
                    .font(.title2)
                    .foregroundColor(Color.green)
            }
            
            Spacer(minLength: 0)

            Button {
                
            } label: {
                Image(systemName: "info.circle.fill")
                    .font(.title2)
                    .foregroundColor(Color.green)
            }
        }
        .padding(.horizontal,60)
//        default frame...
        .frame(height: 50)
        .background(Color.white)
    }
}
