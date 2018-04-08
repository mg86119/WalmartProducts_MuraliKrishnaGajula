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
    
    private let ProductDetailsSegue = "ProductDetailsSegue"
    private let networkService = NetworkService()
    private var pageNumber = 1
    private let productsInPage = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Walmart Products"
        
        mainView.delegate = self
        
        // Get only 1 page of data
        networkService.delegate = self
        networkService.getProductsList(ofPages: pageNumber, ofProducts: productsInPage)
        
        // Show loading
        showLoading(loading: true)
    }
    
    fileprivate func showLoading(loading: Bool) {
        loading ? loadingIndicator.startAnimating() : loadingIndicator.stopAnimating()
    }
    
    fileprivate func retry() {
        showLoading(loading: true)
        networkService.getProductsList(ofPages: pageNumber, ofProducts: productsInPage)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let destination = segue.destination as? ProductDetailsViewController,
            let data = sender as? [String: Any],
            let product = data["product"] as? Product,
            let image = data["image"] as? UIImage {
            destination.viewModel = ProductsDetailsViewModel(image: image, product: product)
        }
    }
}

// MARK: - NetworkServiceDelegate

extension ProductsViewController: NetworkServiceDelegate {
    func taskComplete(_ model: [Product]) {
        mainView.setViewModel(ProductsViewModel(model))
        showLoading(loading: false)
    }
    
    func taskError() {
        showLoading(loading: false)

        // TODO: Have a custom wrapper around UIAlertController to take care of all alerts
        // Show Alert that there is some network issue
        let alert = UIAlertController(title: "Network Error", message: "There is a problem connecting server to retrieve products. Please try again after sometime", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Retry", style: .default, handler: {
            [weak self] action in
            self?.retry()
        })
        alert.addAction(okAction)
        let cancelAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - ProductsTableViewDelegate

extension ProductsViewController: ProductsTableViewDelegate {
    func productDetails(_ product: Product,_ image: UIImage) {
        performSegue(withIdentifier: ProductDetailsSegue, sender: ["product" : product, "image" : image])
    }
    
    func loadNextPage() {
        // Increase page number by 1
        pageNumber = pageNumber + 1
        retry()
    }
}

