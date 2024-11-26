//
//  FavouritesVC.swift
//  rssFeed
//
//  Created by Toni Pavic on 26.11.2024..
//

import UIKit

final class FavouritesVC: UIViewController {
    
    // MARK: - Class lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
    }
}

private extension FavouritesVC {
    func configureSelf() {
        title = "Favourites"
        self.view.backgroundColor = .lightGray
    }
}
