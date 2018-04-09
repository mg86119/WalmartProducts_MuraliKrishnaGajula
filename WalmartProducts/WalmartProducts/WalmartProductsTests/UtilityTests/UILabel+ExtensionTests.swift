//
//  UILabel+ExtensionTests.swift
//  WalmartProductsTests
//
//  Created by Murali Krishna Gajula on 4/8/18.
//  Copyright © 2018 Murali Krishna Gajula. All rights reserved.
//

import XCTest
@testable import WalmartProducts

class UILabel_ExtensionTests: XCTestCase {
    
    var myLabel: UILabel?

    override func setUp() {
        super.setUp()
        myLabel = UILabel()
    }
    
    override func tearDown() {
        myLabel = nil
        super.tearDown()
    }
    
    func testAssignHtmlString() {
        myLabel?.assignHmlString(htmlString: "Hello World", withFontSize: 20)
        XCTAssertNotNil(myLabel?.attributedText)
        XCTAssertEqual(myLabel?.font.pointSize, 20)
    }
    
    func testAssignHtmlStringForNil() {
        myLabel?.assignHmlString(htmlString: nil, withFontSize: 20)
        XCTAssertNil(myLabel?.attributedText)
    }
}
