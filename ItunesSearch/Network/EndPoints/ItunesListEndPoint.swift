//
//  ItunesListEndPoint.swift
//  ItunesSearch
//
//  Created by Renu Punjabi on 4/6/20.
//  Copyright © 2020 Renu Punjabi. All rights reserved.
//

import Foundation

enum ItunesListEndpoint: APIConfiguration {
    case itunesSearch(term: String)
    case itunesArtWork(imageString: String)
    
    struct Constants {
        static let baseURL = "https://itunes.apple.com/"
        static let search = "search"
    }
    
    var method: String {
        switch self {
        case .itunesSearch, .itunesArtWork: return "GET"
        }
    }
    
    //https://itunes.apple.com/search?term=jack+johnson.

    var parameters: [URLQueryItem] {
        switch self {
        case .itunesSearch(let term):
            let searchItem = URLQueryItem(name: "term", value: term)
            return [searchItem]
        case .itunesArtWork:
            return []
        }
    }
    
    var path: String {
        switch self {
        case .itunesSearch:
            return Constants.baseURL + Constants.search
        case .itunesArtWork(let imageString):
            return imageString
        }
    }
    
    
}
