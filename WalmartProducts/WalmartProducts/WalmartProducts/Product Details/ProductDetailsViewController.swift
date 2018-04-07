//
//  ProductDetailsViewController.swift
//  WalmartProducts
//
//  Created by Murali Krishna Gajula on 4/7/18.
//  Copyright © 2018 Murali Krishna Gajula. All rights reserved.
//

import Foundation
import UIKit

class ProductDetailsViewController: UIViewController {
    
    @IBOutlet fileprivate weak var mainView: ProductDetailsTableView!
    private let ExtraDetailsSegue = "ExtraDetailsSegue"
    var viewModel: ProductsDetailsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Product Details"
        mainView.viewModel = viewModel
    }
}
