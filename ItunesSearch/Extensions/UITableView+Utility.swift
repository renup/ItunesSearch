//
//  UITableView+Utility.swift
//  ItunesSearch
//
//  Created by Renu Punjabi on 4/7/20.
//  Copyright © 2020 Renu Punjabi. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) where T: ReusableView {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
        
        guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not deque cell with identifier = \(T.reuseIdentifier)")
        }
        return cell
    }
    
    func dequeReusableCell<T: UITableViewCell>() -> T where T: ReusableView {
           
           guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier) as? T else {
               fatalError("Could not deque cell with identifier = \(T.reuseIdentifier)")
           }
           return cell
       }
}
