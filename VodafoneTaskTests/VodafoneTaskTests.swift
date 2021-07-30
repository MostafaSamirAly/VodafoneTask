//
//  VodafoneTaskTests.swift
//  VodafoneTaskTests
//
//  Created by Mostafa Samir on 25/07/2021.
//

import XCTest
@testable import VodafoneTask

class VodafoneTaskTests: XCTestCase {

    var fetcher: RepositoryFetcher!
    var parser: RepositoryParser!
    var data: Any!
    
    override func setUp() {
        super.setUp()
        parser = RepositoryParser()
        fetcher = RepositoryFetcher(parser: parser)
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "MockApi", ofType: "json")
        let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        data = try? JSONSerialization.jsonObject(with: jsonData!, options: .allowFragments) as! NSArray
    }
    
    func testFetcher() {
        let promise = expectation(description: "Fetcher is fetching data")
        fetcher.fetch(at: 1,success: { (photos) in
            if photos.count == 10{
                XCTAssertEqual(photos[0].author, "Alejandro Escamilla")
                promise.fulfill()
            } else {
                XCTFail("Response is not as Expected")
                promise.fulfill()
            }
        }) { error in
            XCTFail("Responded with error: \(error.localizedDescription)")
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
    }
    
    func testParser() {
        let promise = expectation(description: "Parsing Mock Data")
        parser.parseRepositories(data!, withSuccess: { (photos) in
            if photos.count == 10 {
                XCTAssertEqual(photos[0].author, "Alejandro Escamilla")
                promise.fulfill()
            } else {
                XCTFail("parsed is not as Expected")
                promise.fulfill()
            }
        }) { (error) in
            XCTFail("parsing  error: \(error.localizedDescription)")
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
    }

}
