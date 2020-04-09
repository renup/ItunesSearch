//
//  ImageCacheType.swift
//  ItunesSearch
//
//  Created by Renu Punjabi on 4/8/20.
//  Copyright © 2020 Renu Punjabi. All rights reserved.
//

import Foundation
import UIKit

// Declares in-memory image cache
protocol ImageCacheType: class {
    // Returns the image associated with a given url
    func image(for url: NSString) -> UIImage?
    // Inserts the image of the specified url in the cache
    func insertImage(_ image: UIImage?, for url: NSString)
    // Removes the image of the specified url in the cache
    func removeImage(for url: NSString)
    // Removes all images from the cache
    func removeAllImages()
    // Accesses the value associated with the given key for reading and writing
    subscript(_ url: NSString) -> UIImage? { get set }
}
