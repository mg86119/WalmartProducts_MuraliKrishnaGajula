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
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    weak var delegate: ProductsTableViewDelegate?

    private let CellIdentifier = "ProductsTableViewCell"
    fileprivate var viewModel: ProductsViewModel? {
        didSet {
            tableView.reloadData()
        }
    }
    
    func setViewModel(_ model: ProductsViewModel) {
        guard let vModel = viewModel else {
            viewModel = ProductsViewModel(model.products)
            return
        }
        vModel.products = vModel.products + model.products
        tableView.reloadData()
    }
    
    // MARK: -  UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let vModel = viewModel else {
            return 0
        }
        return vModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let vModel = viewModel,
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath)
            as? ProductsTableViewCell else { return UITableViewCell() }
            cell.setViewModel(vModel.products[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let vModel = viewModel else { return }
        let lastElement = vModel.products.count - 1
        if indexPath.row == lastElement {
            delegate?.loadNextPage()
        }
    }
    
    // MARK: -  UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vModel = viewModel,
            let cell = tableView.cellForRow(at: indexPath) as? ProductsTableViewCell,
            let imageStr = vModel.products[indexPath.row].productImage,
            let imageUrl = URL(string: imageStr),
            let cachedImage = cell.getImageFromCache(imageUrl.absoluteString as NSString) else {
            return
        }
        
        // deselect row first then call curresponding action
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.productDetails(vModel.products[indexPath.row], cachedImage)
    }
}
