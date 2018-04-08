//
//  ProductsDetailsTableViewCell.swift
//  WalmartProducts
//
//  Created by Murali Krishna Gajula on 4/7/18.
//  Copyright © 2018 Murali Krishna Gajula. All rights reserved.
//

import Foundation
import UIKit

class ProductsDetailsTableViewCell: UITableViewCell {
    @IBOutlet fileprivate weak var productImage: UIImageView!
    @IBOutlet fileprivate weak var productName: UILabel!
    @IBOutlet fileprivate weak var price: UILabel!
    @IBOutlet fileprivate weak var rating: UILabel!
    @IBOutlet fileprivate weak var review: UILabel!
    
    func setViewModel(_ viewModel: ProductsDetailsViewModel) {
        productImage.image = viewModel.cachedImage
        productName.text = viewModel.product.productName
        price.text = viewModel.product.price
        rating.text = "\(viewModel.product.reviewRating ?? 0)/5"
        review.text = "(\(viewModel.product.reviewCount ?? 0))"
    }
}
