//
//  ProductsViewModelTests.swift
//  WalmartProductsTests
//
//  Created by Murali Krishna Gajula on 4/8/18.
//  Copyright © 2018 Murali Krishna Gajula. All rights reserved.
//

import XCTest
@testable import WalmartProducts

class ProductsViewModelTests: XCTestCase {
    
    func testInItProductsViewModel() {
        let productId = "666ba307-f7c7-4bb0-bf07-1592387ebc9e"
        let productName = "Ready Set Mount Dual Wall-Mount Shelf System"
        let shortDescription = "Monte Carlo Dual Wall-Mount Shelf System is ideal for audio, video and/or gaming consoles."
        let longDescription = "Ready-Set-Mount presents the elegant Monte Carlo Series.  An innovative component shelving system which creates a dramatic center display in bundling the perfect combination of aesthetics and functionality to compliment toda"
        let price = "$49.88"
        let productImage = "https://walmartlabs-test.appspot.com/images/image2.jpeg"
        let reviewRating = 4.444
        let reviewCount = 9
        let inStock = true
        
        guard let product = Product(json: [
            "productId": productId,
            "productName": productName,
            "shortDescription": shortDescription,
            "longDescription": longDescription,
            "price": price,
            "productImage": productImage,
            "reviewRating": reviewRating,
            "reviewCount": reviewCount,
            "inStock": inStock
            ]) else {
                XCTFail("product can't be nil")
                return
        }
        
        let products = [product]
        XCTAssertNotNil("products can't be nil")
        let viewModel = ProductsViewModel(products)
        XCTAssertNotNil("viewModel can't be nil")
        XCTAssertEqual(viewModel.products.count, 1)
        XCTAssertEqual(viewModel.products[0].productId, productId)
        XCTAssertEqual(viewModel.products[0].productName, productName)
        XCTAssertEqual(viewModel.products[0].shortDescription, shortDescription)
        XCTAssertEqual(viewModel.products[0].longDescription, longDescription)
        XCTAssertEqual(viewModel.products[0].price, price)
        XCTAssertEqual(viewModel.products[0].productImage, productImage)
        XCTAssertEqual(viewModel.products[0].reviewRating, reviewRating)
        XCTAssertEqual(viewModel.products[0].reviewCount, reviewCount)
        XCTAssertEqual(viewModel.products[0].inStock, inStock)
    }
}
