//
//  ProductsDetailsViewModel.swift
//  WalmartProducts
//
//  Created by Murali Krishna Gajula on 4/7/18.
//  Copyright © 2018 Murali Krishna Gajula. All rights reserved.
//

import Foundation
import UIKit

class ProductsDetailsViewModel {
    let cachedImage: UIImage
    let product: Product
    
    init(image: UIImage, product: Product) {
        cachedImage = image
        self.product = product
    }
}
