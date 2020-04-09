//
//  AppCoordinator.swift
//  ItunesSearch
//
//  Created by Renu Punjabi on 4/6/20.
//  Copyright © 2020 Renu Punjabi. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    
    let navigationVC: UINavigationController
    
    var itunesListCoordinator: ItunesListCoordinator?
    
    init(_ navVC: UINavigationController) {
        navigationVC = navVC
    }
    
    func start() {
        beginItunesListFlow()
    }
    
    private func beginItunesListFlow() {
       itunesListCoordinator = ItunesListCoordinator(navVC: navigationVC)
//        navigationVC.pushViewController(itunesListCoordinator?.itunesListVC ?? UIViewController(), animated: true)

        itunesListCoordinator?.start()
    }
    
    
    
}
