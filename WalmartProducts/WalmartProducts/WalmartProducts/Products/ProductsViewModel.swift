//
//  ProductsViewModel.swift
//  WalmartProducts
//
//  Created by Murali Krishna Gajula on 4/7/18.
//  Copyright © 2018 Murali Krishna Gajula. All rights reserved.
//

import Foundation
import UIKit

class ProductsViewModel {
    var products: [Product]
    
    init(_ products: [Product] = []) {
        self.products = products
    }
}
