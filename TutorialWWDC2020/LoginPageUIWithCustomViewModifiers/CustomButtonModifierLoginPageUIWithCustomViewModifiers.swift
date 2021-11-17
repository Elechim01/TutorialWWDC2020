//
//  CustomButtonModifierLoginPageUIWithCustomViewModifiers.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 16/11/21.
//

import SwiftUI

struct CustomButtonModifierLoginPageUIWithCustomViewModifiers: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .foregroundColor(.white)
            .padding(.vertical)
            .padding(.horizontal,35)
            .background(
                LinearGradient(gradient: .init(colors: [Color("yellow-light"),Color("yellow")]), startPoint: .leading, endPoint: .trailing)
            )
            .clipShape(Capsule())
    }
}

