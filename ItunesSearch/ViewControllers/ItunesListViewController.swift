//
//  ItunesListViewController.swift
//  ItunesSearch
//
//  Created by Renu Punjabi on 4/6/20.
//  Copyright © 2020 Renu Punjabi. All rights reserved.
//

import UIKit

class ItunesListViewController: UIViewController {
    
    private lazy var tableView: ItunesListView = {
        let tableView = ItunesListView()
        return tableView
    }()
    
    override func loadView() {
        view = tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }


}

