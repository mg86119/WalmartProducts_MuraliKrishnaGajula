//
//  ProductsTableViewCell.swift
//  WalmartProducts
//
//  Created by Murali Krishna Gajula on 4/6/18.
//  Copyright © 2018 Murali Krishna Gajula. All rights reserved.
//

import Foundation
import UIKit

class ProductsTableViewCell: UITableViewCell {
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    let imageCache = NSCache<NSString, UIImage>()
    
    func configure(_ product: Product) {
        productName.text = product.productName
        guard let imageStr = product.productImage,
            let imageUrl = URL(string: imageStr) else {
            return
        }

        if let cachedImage = imageCache.object(forKey: imageUrl.absoluteString as NSString) {
            productImage.image = cachedImage
        } else {
            productImage.downloadImage(url: imageUrl, completion: { [weak self] (image, error) in
                let finalImage = image ?? UIImage(named: "defaultTableViewCellImage")! //Used forcewrap as its static existing image
                DispatchQueue.main.async {
                    self?.imageCache.setObject(finalImage, forKey: imageUrl.absoluteString as NSString)
                    self?.productImage.image = finalImage
                }
            })
        }
    }
}
