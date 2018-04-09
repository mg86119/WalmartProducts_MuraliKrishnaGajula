//
//  UIlabel+Extension.swift
//  WalmartProducts
//
//  Created by Murali Krishna Gajula on 4/7/18.
//  Copyright © 2018 Murali Krishna Gajula. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func assignHmlString(htmlString: String?, withFontSize size: Int) {
        guard let data = htmlString?.data(using: String.Encoding.unicode) else {
            return
        }

        if let mutableAttributedString = try? NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            let largeFont = UIFont.systemFont(ofSize: CGFloat(size))
            mutableAttributedString.addAttribute(.font, value: largeFont, range: NSMakeRange(0, mutableAttributedString.length))
            attributedText = mutableAttributedString
        }
    }
}
