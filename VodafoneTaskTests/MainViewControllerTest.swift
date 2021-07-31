//
//  MainViewControllerTest.swift
//  VodafoneTaskTests
//
//  Created by Mostafa Samir on 31/07/2021.
//

import XCTest
@testable import VodafoneTask

class MainViewControllerTest: XCTestCase {
    
    var mainViewController: MainViewController?
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let navigationController = storyboard.instantiateInitialViewController() as? UINavigationController
        else {
            XCTFail()
            return
        }
        mainViewController = navigationController.viewControllers.first as? MainViewController
        mainViewController?.loadViewIfNeeded()
    }

    override func tearDown() {
        mainViewController = nil
        super.tearDown()
    }

    func testOutletsShouldBeConnected() {
        XCTAssertNotNil(mainViewController?.photosTableView, "tableView")
    }

    func testTableViewDelegatesShouldBeConnected() {
        mainViewController?.photosTableView.reloadData()
        XCTAssertNotNil(mainViewController?.photosTableView.dataSource, "dataSource")
        XCTAssertNotNil(mainViewController?.photosTableView.delegate, "delegate")
    }

    func testNavigationTitle() {
        XCTAssertEqual(mainViewController?.navigationItem.title, "Photos")
    }

    func testViewModelShouldBeConnected() {
        XCTAssertNotNil(mainViewController?.viewModel)
        XCTAssertNotNil(mainViewController?.viewModel.photos)
        XCTAssertNotNil(mainViewController?.viewModel.cachedPhotos)
    }
    
    func testHandleRefresh() {
        mainViewController?.viewModel.refresh()
        XCTAssertEqual(mainViewController?.viewModel.photos.count, 0)
    }
}
