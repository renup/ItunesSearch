//
//  UIImage+Utilities.swift
//  ItunesSearch
//
//  Created by Renu Punjabi on 4/8/20.
//  Copyright © 2020 Renu Punjabi. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {

    //This function consumes a regular UIImage and returns a decompressed and rendered version. It makes sense to have a cache of decompressed images. This should improve drawing performance, but with the cost of extra storage.
    func decodedImage() -> UIImage {
        guard let cgImage = cgImage else { return self }
        let size = CGSize(width: cgImage.width, height: cgImage.height)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: 8, bytesPerRow: cgImage.bytesPerRow, space: colorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
        context?.draw(cgImage, in: CGRect(origin: .zero, size: size))
        guard let decodedImage = context?.makeImage() else { return self }
        return UIImage(cgImage: decodedImage)
    }
    
    static func loadImage(_ imgURLString: String, completion: @escaping (Result<UIImage?, APIServiceError>) -> Void) -> URLSessionDataTask? {
        
        return ItunesListRouter.fetchImage(imgURLString: imgURLString) { (result) in
            switch result {
            case .success(let data):
                guard let dt = data, let img = UIImage(data: dt) else { return }
                 DispatchQueue.main.async {
                    completion(.success(img))
                }
            case.failure(let error):
             print(error.description)
            }
        }
    }
    
}
