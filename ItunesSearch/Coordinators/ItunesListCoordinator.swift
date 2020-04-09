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
    let factory = ItunesListFactory()
    let navigationVC: UINavigationController
    let itunesListVC: ItunesListViewController = ItunesListViewController()
    private lazy var viewModel = ItunesViewModel()
    
    init(navVC: UINavigationController) {
        navigationVC = navVC
        navigationVC.pushViewController(itunesListVC, animated: true)
    }
    
    func start() {
        beginFlow()
    }
    
    private func beginFlow() {
        getItunesList()
    }
    
    func getItunesList(for searchTerm: String = "jack johnson") {
        viewModel.getItunesList(searchTerm) {[weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let items):
                self.itunesListVC.tableView.items = items
            case .failure(let error):
                if self.viewModel.shouldShowError(error: error) {
                    self.itunesListVC.showAPIError(error)
                }
            }
        }
    }
    

}
