//
//  ProductsTableView.swift
//  WalmartProducts
//
//  Created by Murali Krishna Gajula on 4/6/18.
//  Copyright © 2018 Murali Krishna Gajula. All rights reserved.
//

import Foundation
import UIKit

// TODO: Add 'Go to top' button

protocol ProductsTableViewDelegate: class {
    func productDetails(_ product: Product,_ image: UIImage)
    func loadNextPage()
}

class ProductsTableView: UIView,
                         UITableViewDelegate,
                         UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    private let CellIdentifier = "ProductsTableViewCell"
    weak var delegate: ProductsTableViewDelegate?
    var viewModel = ProductsViewModel()
    
    // MARK: -  UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TimeConstraintComment: Would like to configure custom cell with all the data and use in SchoolsView table
        // based on design
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath)
            as? ProductsTableViewCell else { return UITableViewCell() }
            cell.configure(viewModel.products[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = viewModel.products.count - 1
        if indexPath.row == lastElement {
            delegate?.loadNextPage()
        }
    }
    
    // MARK: -  UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? ProductsTableViewCell,
            let imageStr = viewModel.products[indexPath.row].productImage,
            let imageUrl = URL(string: imageStr),
            let cachedImage = cell.imageCache.object(forKey: imageUrl.absoluteString as NSString) else {
            return
        }

        delegate?.productDetails(viewModel.products[indexPath.row], cachedImage)
    }
}
