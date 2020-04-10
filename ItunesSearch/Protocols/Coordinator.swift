//
//  Coordinator.swift
//  ItunesSearch
//
//  Created by Renu Punjabi on 4/6/20.
//  Copyright © 2020 Renu Punjabi. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator {
    func start()
    var didEnd: () -> Void { get set }
    func end()
}

extension Coordinator {
    func end() { }
    func start() { }
}

protocol NavigationCoordinator: Coordinator {
    var navigationController: UINavigationController { get }
    var returnController: UIViewController? { get set }
}

extension NavigationCoordinator {
    
    func end() {
        guard let returnController = returnController else {
            navigationController.popViewController(animated: true)
            return
        }
        
        guard navigationController.viewControllers.contains(returnController) else { navigationController.popViewController(animated: true)
            return
        }
        navigationController.popToViewController(returnController, animated: true)
        
        didEnd() //closure when the child coordinator flow has ended and we are returning to parentCoordinator. Do any updates from child coordinator in this method or nullify the childCoordinators here if needed
    }
}
