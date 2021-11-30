//
//  CardViewParsingJSONAndStoringToCoreData.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 30/11/21.
//

import SwiftUI

struct CardViewParsingJSONAndStoringToCoreData: View {
    var video: VideoModelParsingJSONAndStoringToCoreData?
    var fetchedData: Video?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            Text(video == nil ? fetchedData!.titleName! :  video!.titleName)
                .font(.title2)
                .fontWeight(.heavy)
                .foregroundColor(.black)
            
            Text(video == nil ? fetchedData!.detail! :  video!.detail)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.gray)
        }
    }
}

