//
//  FilteredImageApplyingFilters.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 08/11/21.
//

import SwiftUI
import CoreImage

struct FilteredImageApplyingFilters: Identifiable {
    var id = UUID().uuidString
    var image: UIImage
    var filter: CIFilter
    var isEditable: Bool
}
