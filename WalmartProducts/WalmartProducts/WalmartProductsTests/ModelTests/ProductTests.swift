//
//  ProductTests.swift
//  WalmartProductsTests
//
//  Created by Murali Krishna Gajula on 4/7/18.
//  Copyright © 2018 Murali Krishna Gajula. All rights reserved.
//

import XCTest
@testable import WalmartProducts

class ProductTests: XCTestCase {
    
    var product: Product?
    let productId = "666ba307-f7c7-4bb0-bf07-1592387ebc9e"
    let productName = "Ready Set Mount Dual Wall-Mount Shelf System"
    let shortDescription = "Monte Carlo Dual Wall-Mount Shelf System is ideal for audio, video and/or gaming consoles."
    let longDescription = "Ready-Set-Mount presents the elegant Monte Carlo Series.  An innovative component shelving system which creates a dramatic center display in bundling the perfect combination of aesthetics and functionality to compliment toda"
    let price = "$49.88"
    let productImage = "https://walmartlabs-test.appspot.com/images/image2.jpeg"
    let reviewRating = 4.444
    let reviewCount = 9
    let inStock = true
    
    override func setUp() {
        super.setUp()
        let json:[String: Any] = [
            "productId": productId,
            "productName": productName,
            "shortDescription": shortDescription,
            "longDescription": longDescription,
            "price": price,
            "productImage": productImage,
            "reviewRating": reviewRating,
            "reviewCount": reviewCount,
            "inStock": inStock
        ]
        product = Product(json: json)
    }
    
    override func tearDown() {
        product = nil
        super.tearDown()
    }
    
    func testInIt() {
        XCTAssert(product != nil, "product object should not be nil")
    }
    
    func testProductId() {
        XCTAssert(product != nil, "product object should not be nil")
        XCTAssertEqual(product?.productId, productId)
    }
    
    func testProductName() {
        XCTAssert(product != nil, "product object should not be nil")
        XCTAssertEqual(product?.productName, productName)
    }
    
    func testShortDescription() {
        XCTAssert(product != nil, "product object should not be nil")
        XCTAssertEqual(product?.shortDescription, shortDescription)
    }
    
    func testLongDescription() {
        XCTAssert(product != nil, "product object should not be nil")
        XCTAssertEqual(product?.longDescription, longDescription)
    }
    
    func testPrice() {
        XCTAssert(product != nil, "product object should not be nil")
        XCTAssertEqual(product?.price, price)
    }
    
    func testProductImage() {
        XCTAssert(product != nil, "product object should not be nil")
        XCTAssertEqual(product?.productImage, productImage)
    }
    
    func testReviewRating() {
        XCTAssert(product != nil, "product object should not be nil")
        XCTAssertEqual(product?.reviewRating, reviewRating)
    }
    
    func testReviewCount() {
        XCTAssert(product != nil, "product object should not be nil")
        XCTAssertEqual(product?.reviewCount, reviewCount)
    }
    
    func testInStock() {
        XCTAssert(product != nil, "product object should not be nil")
        XCTAssertEqual(product?.inStock, inStock)
    }
}
