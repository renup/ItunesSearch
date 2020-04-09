//
//  ItunesListRouter.swift
//  ItunesSearch
//
//  Created by Renu Punjabi on 4/7/20.
//  Copyright © 2020 Renu Punjabi. All rights reserved.
//

import Foundation

final class ItunesListRouter: APIRouter {
    
    func fetchItunesList(searchTerm: String, completion: @escaping (Result<ItunesSearchResponse, APIServiceError>) -> Void) {
        performRequest(route: ItunesListEndpoint.itunesSearch(term: searchTerm), completion: completion)
    }
    
    func fetchImage(imgURLString: String, completion: @escaping (Result<Data?, APIServiceError>) -> Void) -> URLSessionDataTask? {
        performRequestForImage(route: ItunesListEndpoint.itunesArtWork(imageString: imgURLString), completion: completion)
    }
}
