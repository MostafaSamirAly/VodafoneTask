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
        fetchMockData()
    }
    
    override func tearDown() {
        mainViewModel = nil
        super.tearDown()
    }
    
    func fetchMockData() {
        let testBundle = Bundle(for: type(of: self))
                let path = testBundle.path(forResource: "MockApi", ofType: "json")
                let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        guard let data = try? JSONSerialization.jsonObject(with: jsonData!, options: .allowFragments) as? NSArray  else {
            XCTFail()
            return
        }
        let parser = Parser()
        parser.parseData(data, withSuccess: { [weak self] photos in
            XCTAssertEqual(photos.count, 10)
            XCTAssertEqual(photos.first?.author, "Alejandro Escamilla")
            self?.mainViewModel?.photos = photos
        }, error: { error in
            XCTFail(error.localizedDescription)
        })
    }

    func testPhotosCount() {
        let count = mainViewModel?.photos.count ?? 0
        XCTAssertEqual(count, 10)
        XCTAssertEqual(mainViewModel?.lastIndex(),
                       count + count / 5)
    }

    func testPhotoAtRow() {
        let row = 0
        let photo = mainViewModel?.photo(at: IndexPath(row: row, section: 0))
        XCTAssertEqual(photo, mainViewModel?.photos[row])
    }
    
    func testSelectedPhoto() {
        let indexPath = IndexPath(row: 0, section: 0)
        mainViewModel?.setSelectedPhoto(at: indexPath)
        XCTAssertEqual(mainViewModel?.photo(at: indexPath), mainViewModel?.selectedPhoto)
    }
    
    func testResetData() {
        mainViewModel?.refresh()
        guard let photos = mainViewModel?.photos else {
            XCTFail()
            return
        }
        XCTAssertTrue(photos.isEmpty)
    }

}
