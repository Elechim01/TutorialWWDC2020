//
//  ServerViewModelComplexShapesCurvesCustomBottomSheet.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 25/11/21.
//

import SwiftUI

class ServerViewModelComplexShapesCurvesCustomBottomSheet: ObservableObject {

    @Published var servers = [
        ServerComplexShapesCurvesCustomBottomSheet(name: "U.S.A.", flag: "us"),
        ServerComplexShapesCurvesCustomBottomSheet(name: "India", flag: "in"),
        ServerComplexShapesCurvesCustomBottomSheet(name: "Regno Unito", flag: "uk"),
        ServerComplexShapesCurvesCustomBottomSheet(name: "France", flag: "fr"),
        ServerComplexShapesCurvesCustomBottomSheet(name: "Germany", flag: "ge"),
        ServerComplexShapesCurvesCustomBottomSheet(name: "Sigapore", flag: "si"),
    ]
    
    @Published var isConnected = false
    @Published var showSheet = false
    
    @Published var currentServer = ServerComplexShapesCurvesCustomBottomSheet(name: "U.S.A.", flag: "us")
}

