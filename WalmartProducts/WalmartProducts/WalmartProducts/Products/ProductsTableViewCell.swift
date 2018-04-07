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

        downloadImage(url: imageUrl , completion: { (image, error) in
            let finalImage = image ?? UIImage(named: "defaultTableViewCellImage")
            DispatchQueue.main.async {
                self.productImage.image = finalImage
            }
        })
    }
    
    func downloadImage(url: URL, completion: @escaping (_ image: UIImage?, _ error: Error? ) -> Void) {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage, nil)
            print("displaying from cache") // delete me
        } else {
            URLSession.shared.dataTask(with: url, completionHandler: {
                [weak self] (data, response, error) -> Void in
                print("downloading image")
                if let error = error {
                    completion(nil, error)
                } else if let data = data, let image = UIImage(data: data) {
                    self?.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    completion(image, nil)
                } else {
                    completion(nil, nil)
                }
            }).resume()
        }
    }
}
