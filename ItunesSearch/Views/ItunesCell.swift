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
    }
    
    private lazy var artworkView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .center
        view.setContentHuggingPriority(UILayoutPriority.init(rawValue: Layout.high), for: .horizontal)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .left
        label.setContentHuggingPriority(UILayoutPriority.init(rawValue: Layout.mid), for: .horizontal)
        return label
    }()
    
    private lazy var subtextLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 0
        label.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
        return label
    }()
    
}
