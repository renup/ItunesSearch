//
//  ItunesListCoordinatorTests.swift
//  ItunesSearchTests
//
//  Created by Renu Punjabi on 4/10/20.
//  Copyright © 2020 Renu Punjabi. All rights reserved.
//

import XCTest
@testable import ItunesSearch

class ItunesListCoordinatorTests: XCTestCase {
    
    var itunesCoordinator: ItunesListCoordinator!
    var coordinatorSpy: ItunesCoordinatorSpy!

    override func setUpWithError() throws {
        itunesCoordinator = ItunesListCoordinator(navVC: UINavigationController())
        itunesCoordinator.start()
        let navigationVC = UINavigationController(rootViewController: ItunesListViewController())
        coordinatorSpy = ItunesCoordinatorSpy(navVC: navigationVC)
        coordinatorSpy.start()
    }

    override func tearDownWithError() throws {
        itunesCoordinator = nil
        coordinatorSpy = nil
    }
    
    func test_ituesListCoordinator_start_initiates_itunesListViewController() {
        XCTAssertNotNil(itunesCoordinator.itunesListVC)
    }

}

// Testing action methods on itunesListVC
extension ItunesListCoordinatorTests {
    func test_trigger_didSelectItem_initiates_detailVC() {
           coordinatorSpy.triggerDidSelectItem()
           waitForNextRunLoop() //we've enabled the animation to be true for navigation.. so we wait for a bit until the animation completes
           let detail = coordinatorSpy.navigationVC.viewControllers.last
           XCTAssertTrue(((detail as? ItunesListDetailViewController) != nil))
           XCTAssertNotNil(detail)
       }
    
    func test_trigger_refreshList_gives_defaultListWith_jackJohnson_word_search() {
        coordinatorSpy.triggerRefreshList()
        XCTAssertTrue(coordinatorSpy.apiForItunesListCalled)
        let item = coordinatorSpy.items[0]
        XCTAssertEqual(item.artistName, "Jack Johnson")
        XCTAssertEqual(item.songTitle, "Better Together")
    }
    
    func test_trigger_filterContent_gives_searchWordRelated_results() {
        coordinatorSpy.triggerFilterContent()
        let item = coordinatorSpy.items[0]
        XCTAssertEqual(item.artistName, "J")
        XCTAssertEqual(item.songTitle, "J")
    }
}

final class ItunesCoordinatorSpy: ItunesListCoordinator {
    
    var apiForItunesListCalled = false
    
    var items: [ItuneItem] = []
    
    override func getItunesList(for searchTerm: String = "jack johnson") {
        let kit = JsonKit()
        if searchTerm == "J" { items = kit.itunesItems("itunesResultsForJ") } else { items = kit.itunesItems() }
        itunesListVC?.tableView.items = items
        apiForItunesListCalled = true
    }
}


