//
//  APIRouter.swift
//  ItunesSearch
//
//  Created by Renu Punjabi on 4/6/20.
//  Copyright © 2020 Renu Punjabi. All rights reserved.
//

import Foundation
import UIKit

public enum APIServiceError: Error {
       case apiError
       case invalidEndpoint
       case invalidResponse
       case noData
       case decodeError
   }

protocol APIRouter {
    func performRequest<T: Decodable>(route: APIConfiguration, completion: @escaping (Result<T, APIServiceError>) -> Void)
    
    func performRequestForImages(route: APIConfiguration, completion: @escaping (Result<UIImage?, APIServiceError>) -> Void) -> URLSessionTask?
}

extension APIRouter {
    
    private func getURL(route: APIConfiguration) -> URL? {
        let path = route.path
        
        guard var urlComponents = URLComponents(string: path) else { return nil }
        
        urlComponents.queryItems = route.parameters
        guard let url = urlComponents.url else { return nil }
        return url
    }
    
    func performRequestForImages(route: APIConfiguration, completion: @escaping (Result<UIImage?, APIServiceError>) -> Void) -> URLSessionTask? {
        
        guard let url = getURL(route: route) else {
            completion(.failure(.invalidEndpoint))
            return nil
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (result) in
            switch result {
            case .success(let (response, data)):
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                    completion(.failure(.invalidResponse))
                    return
                }
                guard let img = UIImage(data: data) else {
                    completion(.failure(.decodeError))
                    return
                }
                completion(.success(img))
                
            case .failure:
                completion(.failure(.apiError))
            }
        }
        dataTask.resume()
        return dataTask
    }

    func performRequest<T: Decodable>(route: APIConfiguration, completion: @escaping (Result<T, APIServiceError>) -> Void) {
        guard let url = getURL(route: route) else { completion(.failure(.invalidEndpoint)); return }
        
        URLSession.shared.dataTask(with: url) { result in
            
            switch result {
            case .success(let (response, data)):
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                    completion(.failure(.invalidResponse))
                    return
                }
                do{
                    let values = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(values))
                } catch {
                    completion(.failure(.decodeError))
                }
            case .failure(_):
                completion(.failure(.apiError))
            }
        }.resume()
    }
}
