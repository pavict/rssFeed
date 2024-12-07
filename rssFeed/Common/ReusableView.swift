//
//  ReusableView.swift
//  rssFeed
//
//  Created by Toni Pavic on 07.12.2024..
//

import UIKit

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
