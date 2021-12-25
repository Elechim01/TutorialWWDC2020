//
//  ViewSpotifyRedesignAppUI.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 25/12/21.
//

import SwiftUI

struct ViewSpotifyRedesignAppUI: View {
    var body: some View {
        HomeViewSpotifyRedesignAppUI()
//        always datk mode..
            .preferredColorScheme(.dark)
    }
}

struct ViewSpotifyRedesignAppUI_Previews: PreviewProvider {
    static var previews: some View {
        ViewSpotifyRedesignAppUI()
    }
}
