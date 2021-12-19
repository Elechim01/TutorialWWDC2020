//
//  ViewMovieBookingAppUI.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 19/12/21.
//

import SwiftUI

struct ViewMovieBookingAppUI: View {
    
    var body: some View {
        
        NavigationView{
                HomeViewMovieBookingAppUI()
                .navigationBarHidden(true)
        }
    }
}

struct ViewMovieBookingAppUI_Previews: PreviewProvider {
    static var previews: some View {
        ViewMovieBookingAppUI()
    }
}
