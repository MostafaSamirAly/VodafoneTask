//
//  ParsingTests.swift
//  VodafoneTaskTests
//
//  Created by Mostafa Samir on 31/07/2021.
//

import XCTest
@testable import VodafoneTask

class ParsingTests: XCTestCase {

    var parser: RepositoryParser?
    
    override func setUp() {
        super.setUp()
        parser = RepositoryParser()
        
    }
    
    override func tearDown() {
        parser = nil
        super.tearDown()
    }

    func testParsingData() {
        let testBundle = Bundle(for: type(of: self))
                let path = testBundle.path(forResource: "MockApi", ofType: "json")
                let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        guard let data = try? JSONSerialization.jsonObject(with: jsonData!, options: .allowFragments) as? NSArray  else {
            XCTFail()
            return
        }
        parser?.parseRepositories(data, withSuccess: { photos in
            XCTAssertEqual(photos.count, 10)
            XCTAssertEqual(photos.first?.author, "Alejandro Escamilla")
        }, error: { error in
            XCTFail(error.localizedDescription)
        })
    }
}
