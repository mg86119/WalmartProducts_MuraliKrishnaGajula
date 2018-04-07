//
//  ProductsTableView.swift
//  WalmartProducts
//
//  Created by Murali Krishna Gajula on 4/6/18.
//  Copyright © 2018 Murali Krishna Gajula. All rights reserved.
//

import Foundation
import UIKit

// TODO: Add loading indicator for TableView for intial load and subsequent n/w call
// go to top button

protocol ProductsTableViewDelegate: class {
    func productDetails(_ product: Product)
    func loadNextPage()
}

class ProductsTableView: UIView,
                         UITableViewDelegate,
                         UITableViewDataSource {
    
    private let CellIdentifier = "ProductsTableViewCell"
    @IBOutlet weak var tableView: UITableView!
    weak var delegate: ProductsTableViewDelegate?
    var viewModel: [Product] = []
    
    // MARK: -  UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TimeConstraintComment: Would like to configure custom cell with all the data and use in SchoolsView table
        // based on design
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath)
            as? ProductsTableViewCell else { return UITableViewCell() }
            cell.configure(viewModel[indexPath.row])
        print("cell \(indexPath.row)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = viewModel.count - 1
        if indexPath.row == lastElement {
            delegate?.loadNextPage()
        }
    }
    
    // MARK: -  UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.productDetails(viewModel[indexPath.row])
    }
}
