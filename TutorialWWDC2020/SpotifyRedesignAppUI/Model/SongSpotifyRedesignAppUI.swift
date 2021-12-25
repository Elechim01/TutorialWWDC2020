//
//  SongSpotifyRedesignAppUI.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 25/12/21.
//

import SwiftUI

struct SongSpotifyRedesignAppUI: Identifiable {
   
    var id = UUID().uuidString
    var album_name: String
    var album_author: String
    var album_cover: String
}

var recentlyPlayed = [
    SongSpotifyRedesignAppUI(album_name: "prova1", album_author: "prova11", album_cover: "p1"),
    SongSpotifyRedesignAppUI(album_name: "prova2", album_author: "prova12", album_cover: "p2"),
    SongSpotifyRedesignAppUI(album_name: "prova3", album_author: "prova13", album_cover: "p3"),
    SongSpotifyRedesignAppUI(album_name: "prova4", album_author: "prova14", album_cover: "p4")
]

var likedSongs = [
    SongSpotifyRedesignAppUI(album_name: "provag1", album_author: "provag11", album_cover: "g1"),
    SongSpotifyRedesignAppUI(album_name: "provag2", album_author: "provag12", album_cover: "g2"),
    SongSpotifyRedesignAppUI(album_name: "provag3", album_author: "provag13", album_cover: "g3"),
    SongSpotifyRedesignAppUI(album_name: "provag4", album_author: "provag14", album_cover: "g4"),
    SongSpotifyRedesignAppUI(album_name: "provag5", album_author: "provag15", album_cover: "g5"),
    SongSpotifyRedesignAppUI(album_name: "provag6", album_author: "provag16", album_cover: "g6"),
    SongSpotifyRedesignAppUI(album_name: "provag7", album_author: "provag17", album_cover: "g7"),
]

var generes = ["Classic","Hip-Hop","Eletronic","Childout","Dark","Calm","Ambient","Dance"]
