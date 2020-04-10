//
//  UIView+Utilities.swift
//  ItunesSearch
//
//  Created by Renu Punjabi on 4/8/20.
//  Copyright © 2020 Renu Punjabi. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func wrap(view: UIView, insets: UIEdgeInsets = .zero) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
       pin(view: view, to: insets)
    }
    
    func pin(view: UIView, to insets: UIEdgeInsets) {
        view.topAnchor.constraint(equalTo: topAnchor, constant: insets.top).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -insets.bottom).isActive = true
        view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -insets.right).isActive = true
    }
    
    func wrap(view: UIView, exceptTop: Bool = false, exceptLeft: Bool = false, exceptBottom: Bool = false, exceptRight: Bool = false, insets: UIEdgeInsets = .zero) {
        
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        
        if !exceptTop {
            view.topAnchor.constraint(equalTo: topAnchor, constant: insets.top).isActive = true
        }
        
        if !exceptLeft {
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left).isActive = true
        }
        
        if !exceptBottom {
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -insets.bottom).isActive = true
        }
        
        if !exceptRight {
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -insets.right).isActive = true
        }
    }
    
    func wrapToSafeArea(_ view: UIView, exceptTop: Bool = false, exceptLeft: Bool = false, exceptBottom: Bool = false, exceptRight: Bool = false, insets: UIEdgeInsets = .zero) {
       
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        
         if !exceptTop {
            view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: insets.top).isActive = true
        }
               
        if !exceptLeft {
            view.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: insets.left).isActive = true
        }
       
        if !exceptBottom {
            view.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -insets.bottom).isActive = true
        }
       
        if !exceptRight {
            view.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -insets.right).isActive = true
        }
    }
    
}
