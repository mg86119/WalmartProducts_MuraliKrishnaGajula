//
//  NetworkService.swift
//  WalmartProducts
//
//  Created by Murali Krishna Gajula on 4/6/18.
//  Copyright © 2018 Murali Krishna Gajula. All rights reserved.
//

import Foundation

protocol NetworkServiceDelegate: class {
    func taskComplete(_ model: [Product])
    func taskError()
}

// I would like to create a NetworkServiceInterface(wrapper around URLSession)
// to accomplish all network tasks (OR) Use use any external framework through pods
// ---
// based on what project requires/demaands

//TODO: Handle total products and page size to stop network calls
class NetworkService {
    weak var delegate: NetworkServiceDelegate?

    private var task: URLSessionDataTask?
    private let endPoint = "https://walmartlabs-test.appspot.com/_ah/api/walmart/v1"
    private let apiKey = "f29b2358-3e89-4fe9-ba31-1aeda1120139"
    
    public init() {}
    
    func getProductsList(ofPages pageNumber: Int,ofProducts noOfProds: Int) {
        guard task == nil else {
            return // task: URLSessionDataTask? already in progress
        }
        
        guard let url = URL(string: endPoint + "/walmartproducts/\(apiKey)/\(pageNumber)/\(noOfProds)") else {
            notifyDelegateFailure()
            return
        }
        
        let session = URLSession.shared
        // TODO: Need to handle response and error using (data, response, error)
        // Also we can check the "status" flag for 200
        task = session.dataTask(with: url) { [weak self] (data, _, _) in
            guard let data = data else {
                self?.notifyDelegateFailure()
                return
            }
            
            guard let jsonData = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                let jsonProductsArray = jsonData?["products"] as? [[String: Any]] else {
                    self?.notifyDelegateFailure()
                    return
            }

            guard let products = self?.createProducts(withJson: jsonProductsArray) else {
                self?.notifyDelegateFailure()
                return
            }
            self?.notifyDelegateSuccess(products)
        }
        task?.resume()
    }
    
    // Create Products array from the json response
    private func createProducts(withJson jsonComponents: [[String : Any]]) -> [Product] {
        var products = [Product]()
        for jsonComponent in jsonComponents {
            guard let product = Product(json: jsonComponent) else {
                continue
            }
            products.append(product)
        }
        return products
    }
    
    // Failure: Nofity the controller by calling error call back
    private func notifyDelegateFailure() {
        task = nil
        DispatchQueue.main.async {
            self.delegate?.taskError()
        }
    }
    
    // Success: Notify the controller by calling success callback 
    private func notifyDelegateSuccess(_ products: [Product]) {
        task = nil
        DispatchQueue.main.async {
            self.delegate?.taskComplete(products)
        }
    }
}

