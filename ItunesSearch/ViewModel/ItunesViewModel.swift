//
//  ItunesViewModel.swift
//  ItunesSearch
//
//  Created by Renu Punjabi on 4/6/20.
//  Copyright © 2020 Renu Punjabi. All rights reserved.
//

import Foundation

final class ItunesViewModel: APIRouter {
    typealias ItunesSearchResult = ItunesSearchResponse
    let listRouter = ItunesListRouter()
    
    func getItunesList(_ searchTerm: String, completion: @escaping (Result<[ItuneItem], APIServiceError>) -> Void) {
        listRouter.fetchItunesList(searchTerm: searchTerm) { (result) in
            switch result {
            case .success(let response):
                let items = response.results
                completion(.success(items))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
