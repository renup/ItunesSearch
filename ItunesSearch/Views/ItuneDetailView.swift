//
//  ItuneDetailView.swift
//  ItunesSearch
//
//  Created by Renu Punjabi on 4/9/20.
//  Copyright © 2020 Renu Punjabi. All rights reserved.
//

import Foundation
import UIKit

final class ItuneDetailView: UIView {
    
    enum Layout {
        static let spacing: CGFloat = 10
        static let boldFontSize: CGFloat = 15
        static let mediumFontSize: CGFloat = 13
    }
    
    private let cache = ImageCache()
    var urlSessionTask: URLSessionDataTask?

    var item: ItuneItem?
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .center
        return imageView
    }()
    
    private lazy var albumLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: Layout.boldFontSize)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var artistLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: Layout.mediumFontSize)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageView, albumLabel, artistLabel])
        stack.alignment = .center
        stack.axis = .vertical
        stack.spacing = Layout.spacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    init(_ item: ItuneItem) {
        self.item = item
        super.init(frame: UIScreen.main.bounds)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLayout() {
        wrap(view: stackView)
    }
    
    func configure() {
        guard let item = item else { return }
        downloadImageIfNeeded(item.artworkURLString)
        artistLabel.text = item.artistName
        albumLabel.text = item.albumTitle
    }
    
    func downloadImageIfNeeded(_ imageURL: String) {
           if let image = cache[imageURL as NSString] {
               imageView.image = image
           } else {
               urlSessionTask = UIImage.loadImage(imageURL) {[weak self] (result) in
                   guard let self = self else { return }
                   switch result {
                   case .success(let img):
                       self.cache[imageURL as NSString] = img
                       self.imageView.image = img
                   case .failure(let error):
                       print(error.description)
                   }
               }
           }
          }
    
    
}
