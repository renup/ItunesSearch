//
//  ImageCache.swift
//  ItunesSearch
//
//  Created by Renu Punjabi on 4/8/20.
//  Copyright © 2020 Renu Punjabi. All rights reserved.
//

import Foundation
import UIKit


final class ImageCache {

    // 1st level cache, that contains encoded images
    private lazy var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = config.countLimit
        return cache
    }()
    // 2nd level cache, that contains decoded images
    private lazy var decodedImageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.totalCostLimit = config.memoryLimit
        return cache
    }()
    private let lock = NSLock()
    private let config: Config

    struct Config {
        let countLimit: Int
        let memoryLimit: Int

        static let defaultConfig = Config(countLimit: 100, memoryLimit: 1024 * 1024 * 100) // 100 MB
    }

    init(config: Config = Config.defaultConfig) {
        self.config = config
    }
}

extension ImageCache: ImageCacheType {
    func removeAllImages() {
        //clear imageCache and decodedImageCache
        imageCache.removeAllObjects()
        decodedImageCache.removeAllObjects()
    }
    
    func insertImage(_ image: UIImage?, for url: NSString) {
        guard let image = image else { return removeImage(for: url) }
        let decodedImage = image.decodedImage()

        lock.lock(); defer { lock.unlock() }
        imageCache.setObject(decodedImage, forKey: url)
        decodedImageCache.setObject(image, forKey: url)
    }

    func removeImage(for url: NSString) {
        lock.lock(); defer { lock.unlock() }
        imageCache.removeObject(forKey: url)
        decodedImageCache.removeObject(forKey: url)
    }
}

extension ImageCache {
    //To get an image from cache first we should check for the decoded one as the best-case scenario. Next search for an image in the imageCache or return nil as a fallback.
    func image(for url: NSString) -> UIImage? {
        lock.lock(); defer { lock.unlock() }
        // the best case scenario -> there is a decoded image
        if let decodedImage = decodedImageCache.object(forKey: url) {
            return decodedImage
        }
        // search for image data
        if let image = imageCache.object(forKey: url) {
            let decodedImage = image.decodedImage()
            decodedImageCache.setObject(image, forKey: url)
            return decodedImage
        }
        return nil
    }
}

extension ImageCache {
    subscript(_ key: NSString) -> UIImage? {
        get {
            return image(for: key)
        }
        set {
            return insertImage(newValue, for: key)
        }
    }
}
