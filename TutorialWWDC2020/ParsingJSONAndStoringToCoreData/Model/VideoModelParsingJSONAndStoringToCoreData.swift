//
//  VideoModelParsingJSONAndStoringToCoreData.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 30/11/21.
//

import SwiftUI

struct VideoModelParsingJSONAndStoringToCoreData: Decodable,Hashable {
    var titleName: String
    var detail: String
    var imageLink: String
    var link: String
}
