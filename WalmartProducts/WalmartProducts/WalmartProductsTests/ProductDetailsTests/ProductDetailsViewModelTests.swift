//
//  ProductDetailsViewModelTests.swift
//  WalmartProductsTests
//
//  Created by Murali Krishna Gajula on 4/8/18.
//  Copyright © 2018 Murali Krishna Gajula. All rights reserved.
//

import XCTest
@testable import WalmartProducts

class ProductDetailsViewModelTests: XCTestCase {
    
    func testInItOfProductsDetailsViewModel() {
        let productId = "666ba307-f7c7-4bb0-bf07-1592387ebc9e"
        let productName = "Ready Set Mount Dual Wall-Mount Shelf System"
        let shortDescription = "Monte Carlo Dual Wall-Mount Shelf System is ideal for audio, video and/or gaming consoles."
        let longDescription = "Ready-Set-Mount presents the elegant Monte Carlo Series.  An innovative component shelving system which creates a dramatic center display in bundling the perfect combination of aesthetics and functionality to compliment toda"
        let price = "$49.88"
        let productImage = "https://walmartlabs-test.appspot.com/images/image2.jpeg"
        let reviewRating = 4.444
        let reviewCount = 9
        let inStock = true
        
        guard let image = UIImage(named: "defaultTableViewCellImage") else {
            XCTFail("image can't be nil")
            return
        }
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
        let viewModel = ProductsDetailsViewModel(image: image, product: product)
        XCTAssertNotNil(viewModel)
        XCTAssertEqual(viewModel.cachedImage, image)
        XCTAssertEqual(viewModel.product.productId, productId)
        XCTAssertEqual(viewModel.product.productName, productName)
        XCTAssertEqual(viewModel.product.shortDescription, shortDescription)
        XCTAssertEqual(viewModel.product.longDescription, longDescription)
        XCTAssertEqual(viewModel.product.price, price)
        XCTAssertEqual(viewModel.product.productImage, productImage)
        XCTAssertEqual(viewModel.product.reviewRating, reviewRating)
        XCTAssertEqual(viewModel.product.reviewCount, reviewCount)
        XCTAssertEqual(viewModel.product.inStock, inStock)
    }
}
