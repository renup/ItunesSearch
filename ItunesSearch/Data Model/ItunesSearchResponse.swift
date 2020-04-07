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
    var trackName: String
    var artworkUrl30: String
}
