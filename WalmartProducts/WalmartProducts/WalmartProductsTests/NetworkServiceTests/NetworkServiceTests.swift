//
//  NetworkServiceTests.swift
//  WalmartProductsTests
//
//  Created by Murali Krishna Gajula on 4/8/18.
//  Copyright © 2018 Murali Krishna Gajula. All rights reserved.
//

import XCTest
@testable import WalmartProducts

class NetworkServiceTests: XCTestCase {
    
    let endPoint = "https://walmartlabs-test.appspot.com/_ah/api/walmart/v1"
    let apiKey = "f29b2358-3e89-4fe9-ba31-1aeda1120139"
    var networkService: NetworkService?
    var expectation: XCTestExpectation?
    var product: [Product]?
    
    override func setUp() {
        super.setUp()
        networkService = NetworkService()
        networkService?.delegate = self
    }
    
    override func tearDown() {
        networkService = nil
        expectation = nil
        product = nil
        super.tearDown()
    }
    
    func testgetProductsListForSuccess() {
        guard let networkService = networkService else {
            XCTFail("networkService can't be nil")
            return
        }
        
        expectation = expectation(description: "Waiting for networkService to finish")
        networkService.getProductsList(ofPages: 1, ofProducts: 1)
        waitForExpectations(timeout: 5) { [weak self](_) in
            //if the expectation is fulfilled, then it's a success.
            XCTAssertNotNil(self?.product)
            XCTAssert(true)
        }
    }
    
    func testgetProductsListForFailure() {
        guard let networkService = networkService else {
            XCTFail("networkService can't be nil")
            return
        }
        
        expectation = expectation(description: "Waiting for networkService to finish")
        networkService.getProductsList(ofPages: 1, ofProducts: -1)
        waitForExpectations(timeout: 5) { [weak self](_) in
            //if the expectation is fulfilled, then it's a success.
            XCTAssertNil(self?.product)
            XCTAssert(true)
        }
    }
}

extension NetworkServiceTests: NetworkServiceDelegate {
    func taskComplete(_ model: [Product]) {
        networkService?.delegate = nil
        XCTAssertNotNil(model, "Products should not be nil")
        
        product = []
        product = model
        expectation?.fulfill()
    }
    
    func taskError() {
        product = nil
        expectation?.fulfill()
        networkService = nil
    }
}
