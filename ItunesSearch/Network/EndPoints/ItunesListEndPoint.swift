//
//  ItunesListEndPoint.swift
//  ItunesSearch
//
//  Created by Renu Punjabi on 4/6/20.
//  Copyright © 2020 Renu Punjabi. All rights reserved.
//

import Foundation
import UIKit

protocol APIRouter {
    static func performRequest<T: Decodable>(route: APIConfiguration, completion: @escaping (Result<T, Error>) -> Void) -> URLSessionTask?
    
    static func performRequestForImages(route: APIConfiguration, completion: @escaping (Result<UIImage?, Error>) -> Void) -> URLSessionTask?
}

extension APIRouter {
    
    private static func getURL(route: APIConfiguration) -> URL? {
        let path = route.path
        
        guard var urlComponents = URLComponents(string: path) else { return nil }
        
        urlComponents.queryItems = route.parameters
        guard let url = urlComponents.url else { return nil }
        return url
    }
    
    static func performRequest<T: Decodable>(route: APIConfiguration, completion: @escaping (Result<T, Error>) -> Void) -> URLSessionTask? {
        guard let url = getURL(route: route) else { return nil }
        
        let dataTask = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            guard let dt = data else {
                completion(Result.failure(error))
            }
                #if DEBUG
                    print( String(describing: dt))
                #endif
                do {
                    let output = Result { try JSONDecoder().decode(T.self, from: dt) }
                    completion(output)
                } catch {
                    
            }
            
        })
        dataTask.resume()
        return dataTask
    }
}
