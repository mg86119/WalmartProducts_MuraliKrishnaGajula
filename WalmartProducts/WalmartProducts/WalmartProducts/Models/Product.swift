//
//  Product.swift
//  WalmartProducts
//
//  Created by Murali Krishna Gajula on 4/6/18.
//  Copyright © 2018 Murali Krishna Gajula. All rights reserved.
//

import Foundation

class Product {
    let productId: String?
    let productName: String?
    let shortDescription: String?
    let longDescription: String?
    let price: String?
    let productImage: String?
    let reviewRating: Double?
    let reviewCount: Int?
    let inStock: Bool?

    public init?(json: [String: Any]) {
        self.productId = json["productId"] as? String
        self.productName = json["productName"] as? String
        self.shortDescription = json["shortDescription"] as? String
        self.longDescription = json["longDescription"] as? String
        self.price = json["price"] as? String
        self.productImage = json["productImage"] as? String
        self.reviewRating = json["reviewRating"] as? Double
        self.reviewCount = json["reviewCount"] as? Int
        self.inStock = json["inStock"] as? Bool
    }
}
