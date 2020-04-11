//
//  APIRouter.swift
//  ItunesSearch
//
//  Created by Renu Punjabi on 4/6/20.
//  Copyright © 2020 Renu Punjabi. All rights reserved.
//

import Foundation

public enum APIServiceError: Error {
       case apiError
       case invalidEndpoint
       case invalidResponse
       case noData
       case decodeError
    
    var description: String {
        switch self {
        case .apiError:
            return "API failed. Unable to fetch data at this time. Try again in few minutes"
        case .invalidEndpoint:
            return "URL passed was incorrect. Please check if URL and parameters are sent correctly"
        case .invalidResponse:
            return "Invalid response"
        case .noData:
            return "No data received"
        case .decodeError:
            return "There was a problem in decoding your model"
        }
    }
    
   }

protocol APIRouter {
    static func performRequest<T: Decodable>(route: APIConfiguration, completion: @escaping (Result<T, APIServiceError>) -> Void)
    
    static func performRequestForImage(route: APIConfiguration, completion: @escaping (Result<Data?, APIServiceError>) -> Void) -> URLSessionDataTask?
}

extension APIRouter {
    
    static private func getURL(route: APIConfiguration) -> URL? {
        let path = route.path
        
        guard var urlComponents = URLComponents(string: path) else { return nil }
        
        urlComponents.queryItems = route.parameters
        guard let url = urlComponents.url else { return nil }
        return url
    }
    
    static func performRequestForImage(route: APIConfiguration, completion: @escaping (Result<Data?, APIServiceError>) -> Void) -> URLSessionDataTask? {
        
        guard let url = getURL(route: route) else {
            completion(.failure(.invalidEndpoint))
            return nil
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (result) in
            switch result {
            case .success(let (response, data)):
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                    DispatchQueue.main.async {
                        completion(.failure(.invalidResponse))
                    }
                    return
                }
                completion(.success(data))// avoid converting to image from data in main thread
                
            case .failure:
                DispatchQueue.main.async {
                    completion(.failure(.apiError))
                }
            }
        }
        dataTask.resume()
        return dataTask
    }

    static func performRequest<T: Decodable>(route: APIConfiguration, completion: @escaping (Result<T, APIServiceError>) -> Void) {
        guard let url = getURL(route: route) else { completion(.failure(.invalidEndpoint)); return }
        
        URLSession.shared.dataTask(with: url) { result in
            
            switch result {
            case .success(let (response, data)):
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                    DispatchQueue.main.async {
                        completion(.failure(.invalidResponse))
                    }
                    return
                }
                #if DEBUG
                let outputStr  = String(data: data, encoding: String.Encoding.utf8)
                print("outputStr = \(String(describing: outputStr))")
                #endif
                do {
                    let values = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(values))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(.decodeError))
                    }
                }
            case .failure(_):
                DispatchQueue.main.async {
                    completion(.failure(.apiError))
                }
            }
        }.resume()
    }
}
