//
//  ItunesViewModel.swift
//  ItunesSearch
//
//  Created by Renu Punjabi on 4/6/20.
//  Copyright © 2020 Renu Punjabi. All rights reserved.
//

import Foundation
import UIKit

final class ItunesViewModel: APIRouter {
    
    typealias ItunesSearchResult = ItunesSearchResponse
    
    var itemsReceived: (([ItuneItem]) -> Void) = { _ in }
    
    func getItunesList(_ searchTerm: String, completion: @escaping (Result<[ItuneItem], APIServiceError>) -> Void) {
        ItunesListRouter.fetchItunesList(searchTerm: searchTerm) { (result) in
            switch result {
            case .success(let response):
                let items = response.results
                completion(.success(items))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func shouldShowError(error: APIServiceError) -> Bool {
        guard error == .apiError else {  print(error.description); return false }
        return true
    }
    
}

