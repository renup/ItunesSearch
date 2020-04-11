//
//  AppCoordinatorTests.swift
//  ItunesSearchTests
//
//  Created by Renu Punjabi on 4/10/20.
//  Copyright © 2020 Renu Punjabi. All rights reserved.
//

import XCTest
@testable import ItunesSearch

class AppCoordinatorTests: XCTestCase {

    var appCoordinator: AppCoordinator!
    
    override func setUpWithError() throws {
        appCoordinator = AppCoordinator(navVC: UINavigationController())
    }

    override func tearDownWithError() throws {
        appCoordinator = nil
    }
    
    func test_appCoordinator_start_initiates_ituesSearchCoordinator() {
        appCoordinator.start()
        XCTAssertNotNil(appCoordinator.itunesListCoordinator)
    }

}
