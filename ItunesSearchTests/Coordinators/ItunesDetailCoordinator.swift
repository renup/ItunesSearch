//
//  ItunesDetailCoordinator.swift
//  ItunesSearchTests
//
//  Created by Renu Punjabi on 4/11/20.
//  Copyright © 2020 Renu Punjabi. All rights reserved.
//

import XCTest
@testable import ItunesSearch

class ItunesDetailCoordinatorTests: XCTestCase {
    
    override func setUpWithError() throws { }
        
    override func tearDownWithError() throws { }
    
    func test_start_initiates_detailVC() {
        let item = JsonKit().itunesItems().first
        let detailsCoordinator = ItunesDetailCoordinator(UINavigationController(), item: item!, returnController: UIViewController())
        detailsCoordinator.start()
        XCTAssertNotNil(detailsCoordinator.navigationController.viewControllers.last as? ItunesListDetailViewController)
        XCTAssertEqual(detailsCoordinator.itemDetailVC?.item?.artistName, item?.artistName)
        XCTAssertEqual(detailsCoordinator.itemDetailVC?.item?.artworkURLString, item?.artworkURLString)
    }

}
