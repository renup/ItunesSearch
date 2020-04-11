//
//  JsonKit.swift
//  ItunesSearchTests
//
//  Created by Renu Punjabi on 4/10/20.
//  Copyright © 2020 Renu Punjabi. All rights reserved.
//

import Foundation

@testable import ItunesSearch

final class JsonKit {
    
    typealias ItunesSearchResult = ItunesSearchResponse
    
    func loadJson<T: Decodable>(_ fileName: String = "jack johnson") -> T? {
       if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
           do {
               let data = try Data(contentsOf: url)
               let decoder = JSONDecoder()
               let jsonData = try decoder.decode(T.self, from: data)
               return jsonData
           } catch {
               print("error:\(error)")}
           }
       return nil
    }
    
    func itunesItems(_ fileName: String = "jack johnson") -> [ItuneItem] {
        guard let response: ItunesSearchResponse = loadJson(fileName) else { return [] }
        return response.results
    }
    
}
