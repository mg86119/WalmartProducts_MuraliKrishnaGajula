//
//  ProductDetailsTableView.swift
//  WalmartProducts
//
//  Created by Murali Krishna Gajula on 4/7/18.
//  Copyright © 2018 Murali Krishna Gajula. All rights reserved.
//

import Foundation
import UIKit

class ProductDetailsTableView: UIView,
                               UITableViewDelegate,
                               UITableViewDataSource {

    @IBOutlet fileprivate weak var tableView: UITableView!
    private let CellIdentifier = "DetailsCell"
    private let ExtraCellIdentifier = "ExtraInfo"
    fileprivate var viewModel: ProductsDetailsViewModel?
    
    func setViewModel(_ viewModel: ProductsDetailsViewModel?) {
        self.viewModel = viewModel
    }

    // MARK: -  UITableViewDataSource
    
    // TODO: Give different design for compact height using 'Vary for Traits' in storyboard
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath) as? ProductsDetailsTableViewCell,
                let model = viewModel else {
                    return UITableViewCell()
            }
            
            cell.setViewModel(model)
            return cell
        
        case 1:
            guard let model = viewModel, let stock = model.product.inStock else {
                return UITableViewCell()
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: ExtraCellIdentifier, for: indexPath) as UITableViewCell
            
            cell.textLabel?.text = stock ? "Available in Store/Online" : "Currently Not Available"
            cell.textLabel?.textColor = stock ? UIColor.green : UIColor.red
            cell.textLabel?.numberOfLines = 0
            return cell

        default:
            guard let model = viewModel else {
                return UITableViewCell()
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: ExtraCellIdentifier, for: indexPath) as UITableViewCell

            let desc = indexPath.section == 2 ? model.product.shortDescription : model.product.longDescription
            cell.textLabel?.assignHmlString(htmlString: desc, withFontSize: 20)
            cell.textLabel?.numberOfLines = 0
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = ""
        switch section {
        case 1:
            title = "In Stock"
        case 2:
            title = "Short Description"
        case 3:
            title = "Long Description"
        default:
            break
        }
        return title
    }
}
