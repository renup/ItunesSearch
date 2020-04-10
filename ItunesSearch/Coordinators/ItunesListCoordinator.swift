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
    
    init(navVC: UINavigationController) {
        navigationVC = navVC
        start()
    }
    
    func start() {
        guard let itunesVC = navigationVC.viewControllers.first as? ItunesListViewController else { assertionFailure(); return }
        itunesListVC = itunesVC
        itunesListVC?.didSelectItem = {[weak self] item in
            self?.beginDetailFlow(item)
        }
        beginFlow()
    }
    
    private func beginFlow() {
        getItunesList()
    }
    
    private func beginDetailFlow(_ item: ItuneItem) {
        let detailVC = ItunesListDetailViewController()
        detailVC.item = item
        
    }
    
    func getItunesList(for searchTerm: String = "jack johnson") {
        viewModel.getItunesList(searchTerm) {[weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let items):
                self.itunesListVC?.tableView.items = items
            case .failure(let error):
                if self.viewModel.shouldShowError(error: error) {
                    self.itunesListVC?.showAPIError(error)
                }
            }
        }
    }
    

}
