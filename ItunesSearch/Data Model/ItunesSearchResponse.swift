//
//  ItunesSearchResponse.swift
//  ItunesSearch
//
//  Created by Renu Punjabi on 4/7/20.
//  Copyright © 2020 Renu Punjabi. All rights reserved.
//

import Foundation

struct ItunesSearchResponse: Decodable {
    var results: [ItuneItem]
}

struct ItuneItem: Decodable {
    var artistName: String
    var artThumbnail: String
    var songTitle: String
    var albumTitle: String
    
    enum CodingKeys: String, CodingKey {
        case artistName
        case artThumbnail = "artworkUrl30"
        case songTitle = "trackName"
        case albumTitle = "collectionName"
    }
}
