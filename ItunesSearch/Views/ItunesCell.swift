//
//  ItunesCell.swift
//  ItunesSearch
//
//  Created by Renu Punjabi on 4/7/20.
//  Copyright © 2020 Renu Punjabi. All rights reserved.
//

import Foundation
import UIKit

final class ItunesCell: UITableViewCell, ReusableView {
    enum Layout {
        static let high: Float = 1000
        static let mid: Float = 999
        static let spacing: CGFloat = 8
        static let insets = UIEdgeInsets(top: 16, left: 20, bottom: 16, right: 20)
        static let separatorInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        static let cellHeight: CGFloat = 60
        static let upperStackToSubTextSpacing: CGFloat = -10
    }
    
    private let cache = ImageCache()

    var urlSessionTask: URLSessionDataTask?

    private(set) lazy var artworkView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .center
        view.setContentHuggingPriority(UILayoutPriority.init(rawValue: Layout.high), for: .horizontal)
        return view
    }()
    
    //Song title
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
        return label
    }()
    
    //Album title
    private(set) lazy var subtextLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 0
        label.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
        return label
    }()
    
    //Artist name
    private(set) lazy var sideLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        label.numberOfLines = 0
        label.textAlignment = .right
        label.setContentHuggingPriority(UILayoutPriority.init(rawValue: Layout.mid), for: .horizontal)
        return label
    }()
    
    private(set) lazy var upperStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [artworkView, titleLabel, sideLabel])
        stack.alignment = .center
        stack.axis = .horizontal
        stack.spacing = Layout.spacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        separatorInset = Layout.separatorInsets
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ dataModel: ItuneItem) {
        artworkView.image = UIImage(named: "thumbnail_placeholder")
        downloadImageIfNeeded(dataModel.artThumbnailURLString)
        titleLabel.text = dataModel.songTitle
        subtextLabel.text = dataModel.albumTitle
        sideLabel.text = dataModel.artistName
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        artworkView.image = nil
        titleLabel.text = nil
        subtextLabel.text = nil
        sideLabel.text = nil
        urlSessionTask?.cancel()
        urlSessionTask = nil
    }
    
}

extension ItunesCell {
    private func configureLayout() {
        wrap(view: upperStack, exceptBottom: true, insets: Layout.insets)
        wrap(view: subtextLabel, exceptTop: true, insets: Layout.insets)
        upperStack.bottomAnchor.constraint(equalTo: subtextLabel.topAnchor, constant: Layout.upperStackToSubTextSpacing).isActive = true
    }
    
    func downloadImageIfNeeded(_ imageURL: String) {
        if let image = cache[imageURL as NSString] {
            artworkView.image = image
        } else {
            urlSessionTask = UIImage.loadImage(imageURL) {[weak self] (result) in
                guard let self = self else { return }
                switch result {
                case .success(let img):
                    self.cache[imageURL as NSString] = img
                    self.artworkView.image = img
                case .failure(let error):
                    print(error.description)
                }
            }
        }
       }
}
