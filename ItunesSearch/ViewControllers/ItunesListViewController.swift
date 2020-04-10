//
//  ItunesListViewController.swift
//  ItunesSearch
//
//  Created by Renu Punjabi on 4/6/20.
//  Copyright © 2020 Renu Punjabi. All rights reserved.
//

import UIKit

class ItunesListViewController: UIViewController {
    
    lazy var tableView: ItunesListView = {
        let tableView = ItunesListView()
        tableView.didSelectItuneItem = { [weak self] item in
            self?.didSelectItem(item)
        }
        return tableView
    }()

    var didSelectItem: (ItuneItem) -> Void = { _ in }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = tableView
        title = "Songs List"
    }

}

