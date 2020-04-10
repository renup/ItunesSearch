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
    var artThumbnailURLString: String
    var artworkURLString: String
    var songTitle: String
    var albumTitle: String
    
    enum CodingKeys: String, CodingKey {
        case artistName
        case artThumbnailURLString = "artworkUrl60"
        case artworkURLString = "artworkUrl100"
        case songTitle = "trackName"
        case albumTitle = "collectionName"
    }
}
