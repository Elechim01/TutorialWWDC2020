//
//  RecentRowViewComplexHeroAnimations.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 22/12/21.
//

import SwiftUI

struct RecentRowViewComplexHeroAnimations: View {
    
    var recent: ProfileComplexHeroAnimations
    var animation: Namespace.ID
    
//    Enviroment Object...
    @EnvironmentObject var profileData: ProfileDetailModelComplexHeroAnimations
    
    var body: some View {
        
        HStack(spacing: 15){
            
//            Making it as clickable Button...
            Button {
                withAnimation {
                    profileData.selectedProfile = recent
                    profileData.showProfile.toggle()
                }
            } label: {
                
                ZStack{
//                 Without matched geometry effect simply showing image...
                    Image(recent.profile)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                    
                    if !profileData.showProfile{
                        
                        Image(recent.profile)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        //                Matched Geometry Effect..
                        //                Giving unique ID that is from UUID from profile Model....
                            .matchedGeometryEffect(id: recent.id, in: animation)
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                    }
                    
                }
            }
//          it decreased the highlight color..
            .buttonStyle(PlainButtonStyle())
            
            VStack{
                
                HStack{
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text(recent.userName)
                            .fontWeight(.bold)
                        
                        Text(recent.lastMsg)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer(minLength: 10)
                    
                    Text(recent.time)
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
                
                Divider()
            }
            
        }
        .padding(.horizontal)
    }
}

struct RecentRowViewComplexHeroAnimations_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewComplexHeroAnimations()
    }
}
