//
//  UITableView+Extensions.swift
//  rssFeed
//
//  Created by Toni Pavic on 07.12.2024..
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) where T: ReusableView {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func register<T: UITableViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerHeaderFooter<T: UITableViewHeaderFooterView>(_: T.Type) where T: ReusableView, T: NibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        
        register(nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }
    
    final func dequeue<T: UITableViewCell>(for indexPath: IndexPath, type: T.Type = T.self) -> T
    where T: ReusableView {
        let deqCell = self.dequeueReusableCell(withIdentifier: type.reuseIdentifier, for: indexPath)
        guard let cell = deqCell as? T else {
            fatalError(
                "Failed to dequeue a cell with identifier \(type.reuseIdentifier) matching type \(type.self). "
                + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                + "and that you registered the cell beforehand."
            )
        }
        return cell
    }
    
    final func dequeue<T: UITableViewCell>(for indexPath: IndexPath, type: T.Type = T.self) -> T
    where T: ReusableView, T: NibLoadableView {
        let deqCell = self.dequeueReusableCell(withIdentifier: type.reuseIdentifier, for: indexPath)
        guard let cell = deqCell as? T else {
            fatalError(
                "Failed to dequeue a cell with identifier \(type.reuseIdentifier) matching type \(type.self). "
                + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                + "and that you registered the cell beforehand."
            )
        }
        return cell
    }
    
    final func dequeueHeaderFooter<T: UITableViewHeaderFooterView>(type: T.Type = T.self) -> T
    where T: ReusableView, T: NibLoadableView {
        let deqView = self.dequeueReusableHeaderFooterView(withIdentifier: type.reuseIdentifier)
        guard let view = deqView as? T else {
            fatalError(
                "Failed to dequeue a header/footer view with identifier \(type.reuseIdentifier) matching type \(type.self). "
                + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                + "and that you registered the header/footer view beforehand."
            )
        }
        return view
    }
}
