//
//  NibLoadableView.swift
//  rssFeed
//
//  Created by Toni Pavic on 07.12.2024..
//

import UIKit

protocol NibLoadableView {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}
