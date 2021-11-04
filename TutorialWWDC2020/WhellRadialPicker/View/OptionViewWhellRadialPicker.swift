//
//  OptionViewWhellRadialPicker.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 03/11/21.
//

import SwiftUI

struct OptionViewWhellRadialPicker: View {
    var image: String
    var body: some View {
        Button {
            
        } label: {
            Image(systemName: image)
                .font(.title2)
                .foregroundColor(.white)
        }

    }
}

