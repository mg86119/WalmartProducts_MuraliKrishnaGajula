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
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var review: UILabel!
    
    func configure(_ viewModel: ProductsDetailsViewModel) {
        productImage.image = viewModel.cachedImage
        productName.text = viewModel.product.productName
        price.text = viewModel.product.price
        rating.text = "\(viewModel.product.reviewRating ?? 0)/5"
        review.text = "(\(viewModel.product.reviewCount ?? 0))"
    }
}
