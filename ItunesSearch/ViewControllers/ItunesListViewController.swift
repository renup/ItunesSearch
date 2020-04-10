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
        
        tableView.searching = {[weak self] searchText in
            self?.filterContent(searchText)
        }
        
        tableView.refreshList = {[weak self] in
            self?.refreshList()
        }
        return tableView
    }()
    
    var didSelectItem: (ItuneItem) -> Void = { _ in }
    var filterContent: (String) -> Void = { _ in }
    var refreshList: () -> Void = {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = tableView
        title = "Songs List"
        navigationItem.searchController = tableView.searchController
        definesPresentationContext = true
    }
    
    

}

