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
    var didEnd: () -> Void = {}
    
    init(navVC: UINavigationController) {
        navigationVC = navVC
    }
    
    func start() {
        itunesListCoordinator = ItunesListCoordinator(navVC: navigationVC)
        itunesListCoordinator?.start()
    }
    
    
    
}
