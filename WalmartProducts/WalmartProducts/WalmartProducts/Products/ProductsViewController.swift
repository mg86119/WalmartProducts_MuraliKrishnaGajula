//
//  ProductsViewController.swift
//  WalmartProducts
//
//  Created by Murali Krishna Gajula on 4/6/18.
//  Copyright © 2018 Murali Krishna Gajula. All rights reserved.
//

import Foundation
import UIKit

class ProductsViewController: UIViewController {
    
    @IBOutlet fileprivate weak var mainView: ProductsTableView!
    @IBOutlet fileprivate weak var loadingIndicator: UIActivityIndicatorView!
    
    private let DetailSegue = "DetailSegue"
    private let networkService = NetworkService()
    private var pageNumber = 1
    private let productsInPage = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Walmart Products"
        
        mainView.delegate = self
        
        // Get only 1 page of data
        networkService.delegate = self
        networkService.getProductsList(ofPages: pageNumber, ofProducts: productsInPage)
        
        // Show loading
        showLoading(loading: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
       /* if let destination = segue.destination as? SchoolDetailsViewController,
            let data = sender as? Description {
            destination.model = data
        }*/
    }
    
    fileprivate func showLoading(loading: Bool) {
        loading ? loadingIndicator.startAnimating() : loadingIndicator.stopAnimating()
    }
}

// MARK: - NetworkServiceDelegate

extension ProductsViewController: NetworkServiceDelegate {
    func taskComplete(_ model: [Product]) {
        mainView.viewModel = mainView.viewModel + model
        mainView.tableView.reloadData()
        showLoading(loading: false)
    }
    
    func taskError() {
        showLoading(loading: false)
        //TODO : Retry hitting & loading products
    }
}

// MARK: -

extension ProductsViewController: ProductsTableViewDelegate {
    func productDetails(_ product: Product) {
        
    }
    
    func loadNextPage() {
        showLoading(loading: true)
        // Increase page number by 1
        pageNumber = pageNumber + 1
        print("next 30 and page number \(pageNumber)")
        networkService.getProductsList(ofPages: pageNumber, ofProducts: productsInPage)
    }
}

