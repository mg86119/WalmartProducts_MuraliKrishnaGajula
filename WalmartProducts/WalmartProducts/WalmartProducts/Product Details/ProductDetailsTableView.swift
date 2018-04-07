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

    @IBOutlet weak var tableView: UITableView!
    private let CellIdentifier = "DetailsCell"
    private let ExtraCellIdentifier = "ExtraInfo"
    var viewModel: ProductsDetailsViewModel?
    
    // MARK: -  UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
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
            
            cell.configure(model)
            return cell
            
        default:
            guard let model = viewModel else {
                return UITableViewCell()
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: ExtraCellIdentifier, for: indexPath) as UITableViewCell

            let desc = indexPath.section == 1 ? model.product.shortDescription : model.product.longDescription
            cell.textLabel?.assignHmlString(htmlString: desc, withFontSize: 20)
            cell.textLabel?.numberOfLines = 0
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = ""
        switch section {
        case 1:
            title = "Short Description"
        case 2:
            title = "Long Description"
        default:
            break
        }
        return title
    }
}
