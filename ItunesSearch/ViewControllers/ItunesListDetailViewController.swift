//
//  ItunesListDetailViewController.swift
//  ItunesSearch
//
//  Created by Renu Punjabi on 4/9/20.
//  Copyright © 2020 Renu Punjabi. All rights reserved.
//

import Foundation
import UIKit

final class ItunesListDetailViewController: UIViewController {
    
    var item: ItuneItem?
    
    var detailView: ItuneDetailView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = item?.songTitle
        guard let item = item else { return }
        view = ItuneDetailView(item)
    }
    
    
}
