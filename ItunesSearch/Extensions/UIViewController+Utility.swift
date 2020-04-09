//
//  UIViewController+Utility.swift
//  ItunesSearch
//
//  Created by Renu Punjabi on 4/8/20.
//  Copyright © 2020 Renu Punjabi. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAPIError(_ error: APIServiceError) {
        let alert = UIAlertController(title: "Request Failed", message: error.description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        alert.present(self, animated: true, completion: nil)
    }
    
}
