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
         
    var didSelectItuneItem: (ItuneItem) -> Void = { _ in }
    let searchController = UISearchController(searchResultsController: nil)
    var searching: (String) -> Void = { _ in }
    var refreshList: () -> Void = { }
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    init() {
        super.init(frame: .zero, style: .plain)
        backgroundColor = .white
        registerCell()
        delegate = self
        dataSource = self
        setUpSearch()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func registerCell() {
        register(ItunesCell.self)
    }
    
    private func setUpSearch() {
      searchController.searchResultsUpdater = self
      searchController.obscuresBackgroundDuringPresentation = false
      searchController.searchBar.placeholder = "Search by artist name"
   }
    
    @objc private func filterContentForSearchText(_ searchText: String) {
        searching(searchText)
    }
    
    func refreshItems() {
        refreshList()
    }
}

extension ItunesListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
          tableView.deselectRow(at: indexPath, animated: true)
        }
        let item = items[indexPath.row]
        didSelectItuneItem(item)
    }
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

extension ItunesListView: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let searchText = searchBar.text
        perform(#selector(filterContentForSearchText), with: searchText, afterDelay: 3.0)
    }
}

extension ItunesListView: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        refreshItems()
    }
}
