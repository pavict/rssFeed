//
//  UILabel.swift
//  rssFeed
//
//  Created by Toni Pavic on 07.12.2024..
//

import UIKit

extension UILabel {
    static func label(with title: String,
                      font: UIFont = Fonts.body,
                      textColor: UIColor = Colors.label,
                      textAlignment: NSTextAlignment = .left,
                      numberOfLines: Int = 0,
                      lineBreakMode: NSLineBreakMode = .byWordWrapping) -> UILabel {
        let label = UILabel()
        label.font = font
        label.adjustsFontForContentSizeCategory = true
        label.textColor = textColor
        label.textAlignment = textAlignment
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = title
        return label
    }
}
