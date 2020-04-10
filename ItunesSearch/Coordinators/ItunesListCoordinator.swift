//
//  ItunesListCoordinator.swift
//  ItunesSearch
//
//  Created by Renu Punjabi on 4/6/20.
//  Copyright © 2020 Renu Punjabi. All rights reserved.
//

import Foundation
import UIKit

final class ItunesListCoordinator: Coordinator {
    let navigationVC: UINavigationController
    var itunesListVC: ItunesListViewController?
    private lazy var viewModel = ItunesViewModel()
    var itunesDetailCoordinator: ItunesDetailCoordinator?
    var didEnd: () -> Void = { }

    init(navVC: UINavigationController) {
        navigationVC = navVC
    }
    
    func start() {
        guard let itunesVC = navigationVC.viewControllers.first as? ItunesListViewController else { assertionFailure(); return }
        itunesListVC = itunesVC
        itunesListVC?.didSelectItem = {[weak self] item in
            self?.beginDetailFlow(item)
        }
        itunesListVC?.filterContent = {[weak self] searchText in
            self?.getItunesList(for: searchText)
        }
        itunesListVC?.refreshList = {[weak self] in
            self?.getItunesList()
        }
        beginFlow()
    }
    
    private func beginFlow() {
        getItunesList()
    }
    
    private func beginDetailFlow(_ item: ItuneItem) {
        guard let listVC = itunesListVC else { return }
        let detailCoordinator = ItunesDetailCoordinator(navigationVC, item: item, returnController: listVC)
        detailCoordinator.start()
    }
    
    private func getItunesList(for searchTerm: String = "jack johnson") {
        itunesListVC?.showActivityIndicator()
        var searchText = searchTerm
        if searchTerm.isEmpty { searchText = "jack johnson" }
        //TODO: Check if there is response saved in the disk before making this api call. If exists, return saved response if not, continue
            viewModel.getItunesList(searchText) {[weak self] (result) in
               guard let self = self else { return }
               switch result {
               case .success(let items):
                   self.itunesListVC?.tableView.items = items
                //TODO: Write to disk
               case .failure(let error):
                   if self.viewModel.shouldShowError(error: error) {
                       self.itunesListVC?.showAPIError(error)
                   }
               }
           }
        self.itunesListVC?.hideActivityIndicator()
    }
    

}
