//
//  FavouritesCoordinator.swift
//  rssFeed
//
//  Created by Toni Pavic on 06.12.2024..
//

import UIKit

final class FavouritesCoordinator: Coordinator {
    
    // MARK: - Private properties
    
    private let navigationController: UINavigationController
    
    // MARK: - Class lifecycle
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        setFavouritesScreen()
    }
}

private extension FavouritesCoordinator {
    private func setFavouritesScreen() {
        let favouritesVM = FavouritesVM()
        let favouritesVC = FavouritesVC.instantiate(viewModel: favouritesVM)
        
        navigationController.pushViewController(favouritesVC, animated: true)
    }
}
