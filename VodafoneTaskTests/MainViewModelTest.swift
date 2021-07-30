//
//  MainViewModelTest.swift
//  VodafoneTaskTests
//
//  Created by Mostafa Samir on 31/07/2021.
//

import XCTest
@testable import VodafoneTask

class MainViewModelTests: XCTestCase {

    var mainViewModel: MainViewModel?
    
    override func setUp() {
        super.setUp()
        mainViewModel = MainViewModel()
        mainViewModel?.fetchData()
    }
    
    override func tearDown() {
        mainViewModel = nil
        super.tearDown()
    }

    func testResetData() {
        mainViewModel?.refresh()
        guard let photos = mainViewModel?.photos else {
            XCTFail()
            return
        }
        XCTAssertTrue(photos.isEmpty)
    }

    func getArticlesCountTest() {
        XCTAssertEqual(mainViewModel?.lastIndex(),
                       mainViewModel?.photos.count ?? 0)
    }

    func getArticleAtRowTest() {
        let row = 0
        let photo = mainViewModel?.photo(at: IndexPath(row: row, section: 0))
        XCTAssertEqual(photo, mainViewModel?.photos[row])
    }
}
