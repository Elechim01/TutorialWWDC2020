//
//  HomeViewComplexHeroAnimations.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 22/12/21.
//

import SwiftUI

struct HomeViewComplexHeroAnimations: View {
    
    var animation: Namespace.ID
    @EnvironmentObject var profileData: ProfileDetailModelComplexHeroAnimations
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 15) {
                
                Text("WhatsApp")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .padding(.top)
                
                ForEach(recents){recent in
                    
//                    Recent row View...
                    RecentRowViewComplexHeroAnimations(recent: recent,animation: animation)
                }
            }
        }
        .overlay(
            ZStack(alignment: .top, content: {
                if profileData.showProfile{
                    ProfileDetailViewComplexHeroAnimations(animation: animation)
                }
            })
        )
    }
}

struct HomeViewComplexHeroAnimations_Previews: PreviewProvider {
    static var previews: some View {
        ViewComplexHeroAnimations()
    }
}
