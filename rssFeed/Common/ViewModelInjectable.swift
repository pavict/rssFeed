//
//  ViewModelInjectable.swift
//  rssFeed
//
//  Created by Toni Pavic on 07.12.2024..
//

import UIKit

protocol ViewModelInjectable: AnyObject {
    associatedtype ViewModel
}

private var viewModelKey = "ViewController.viewmodel"

extension ViewModelInjectable where Self: UIViewController {
    var viewModel: ViewModel {
        get {
            guard let viewModel = objc_getAssociatedObject(self, &viewModelKey) as? ViewModel else {
                fatalError("ViewModel not set for \(Self.self).")
            }
            return viewModel
        }
        set {
            objc_setAssociatedObject(self, &viewModelKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    static func instantiate(viewModel: ViewModel) -> Self {
        let vc = Self()
        vc.viewModel = viewModel
        return vc
    }
}
