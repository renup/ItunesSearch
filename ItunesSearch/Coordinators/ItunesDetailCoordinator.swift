//
//  ItunesDetailCoordinator.swift
//  ItunesSearch
//
//  Created by Renu Punjabi on 4/9/20.
//  Copyright © 2020 Renu Punjabi. All rights reserved.
//

import Foundation
import UIKit

final class ItunesDetailCoordinator: NavigationCoordinator {
    var navigationController: UINavigationController
    var returnController: UIViewController?
    var itemDetailVC: ItunesListDetailViewController?
    var item: ItuneItem
    
    var didEnd: () -> Void = { }
    
    init(_ navigationVC: UINavigationController, item: ItuneItem, returnController: UIViewController) {
        self.navigationController = navigationVC
        self.item = item
        self.returnController = returnController
    }
    
    func start() {
        let detailVC = ItunesListDetailViewController()
        itemDetailVC = detailVC
        itemDetailVC?.item = item
        navigationController.pushViewController(detailVC, animated: true)
    }
}
