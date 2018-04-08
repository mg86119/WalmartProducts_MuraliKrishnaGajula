//
//  UIImageView+ExtensionTests.swift
//  WalmartProductsTests
//
//  Created by Murali Krishna Gajula on 4/8/18.
//  Copyright © 2018 Murali Krishna Gajula. All rights reserved.
//

import XCTest
@testable import WalmartProducts

class UIImageView_ExtensionTests: XCTestCase {
    
    let imageUrl = "https://walmartlabs-test.appspot.com/images/image5.jpeg"
    var imageView: UIImageView?
    var expectation: XCTestExpectation?
    
    override func setUp() {
        super.setUp()
        imageView = UIImageView()
    }
    
    override func tearDown() {
        imageView = nil
        super.tearDown()
    }
    
    func testDownloadImageForImage() {
        expectation = expectation(description: "Waiting for networkService to finish")
        if let url = URL(string: imageUrl) {
            imageView?.downloadImage(url: url, completion: { [weak self](image, error) in
                if let image = image {
                    XCTAssertNotNil(image)
                    self?.expectation?.fulfill()
                } else {
                    XCTFail("downloadImage failed with error \(String(describing: error))")
                }
            })
        } else {
            XCTFail("downloadImage failed while making a URL with \(imageUrl)")
        }

        waitForExpectations(timeout: 2, handler: {
            error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        })
    }
    
    func testDownloadImageForError() {
        expectation = expectation(description: "Waiting for networkService to finish")
        if let url = URL(string: "https://dummayurl.jpg") {
            imageView?.downloadImage(url: url, completion: { [weak self](image, error) in
                if let image = image {
                    XCTFail("downloadImage succeded with image \(image)")
                } else {
                    XCTAssertNotNil(error)
                    self?.expectation?.fulfill()
                }
            })
        } else {
            XCTFail("downloadImage failed while making a URL with \(imageUrl)")
        }
        
        waitForExpectations(timeout: 2, handler: {
            error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        })
    }
}
