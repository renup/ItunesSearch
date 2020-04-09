//
//  ItunesListView.swift
//  ItunesSearch
//
//  Created by Renu Punjabi on 4/6/20.
//  Copyright © 2020 Renu Punjabi. All rights reserved.
//

import Foundation
import UIKit

final class ItunesListView: UITableView {
    
    var items: [ItuneItem] = [] {
        didSet {
            reloadData()
        }
    }
        
    init() {
        super.init(frame: .zero, style: .plain)
        backgroundColor = .white
        registerCell()
        delegate = self
        dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func registerCell() {
        register(ItunesCell.self)
    }
}

extension ItunesListView: UITableViewDelegate {
    
}

extension ItunesListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeReusableCell(for: indexPath) as ItunesCell
        cell.configure(items[indexPath.row])
        return cell
    }
    
    
}
