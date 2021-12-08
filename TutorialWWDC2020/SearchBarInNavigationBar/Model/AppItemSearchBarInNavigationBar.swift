//
//  AppItemSearchBarInNavigationBar.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 08/12/21.
//

import SwiftUI

// Model And Sample Data...
struct AppItemSearchBarInNavigationBar: Identifiable {
   
    var id = UUID().uuidString
    var name: String
    var source: String = "Apple"
}

var apps = [
    AppItemSearchBarInNavigationBar(name: "App Store"),
    AppItemSearchBarInNavigationBar(name: "Calculator"),
    AppItemSearchBarInNavigationBar(name: "Calendar"),
    AppItemSearchBarInNavigationBar(name: "Camera"),
    AppItemSearchBarInNavigationBar(name: "Clock"),
    AppItemSearchBarInNavigationBar(name: "Facetime"),
    AppItemSearchBarInNavigationBar(name: "Healt"),
    AppItemSearchBarInNavigationBar(name: "Mail"),
]

