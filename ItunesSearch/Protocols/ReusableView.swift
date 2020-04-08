//
//  ReusableView.swift
//  ItunesSearch
//
//  Created by Renu Punjabi on 4/7/20.
//  Copyright © 2020 Renu Punjabi. All rights reserved.
//

import Foundation
import UIKit

protocol ReusableView: class { }

extension ReusableView where Self: UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: reuseIdentifier, bundle: nil)
    }
}
