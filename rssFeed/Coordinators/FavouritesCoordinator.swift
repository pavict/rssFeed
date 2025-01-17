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
    private let feedService: FeedServiceProtocol
    
    // MARK: - Class lifecycle
    
    init(navigationController: UINavigationController, feedService: FeedServiceProtocol) {
        self.navigationController = navigationController
        self.feedService = feedService
    }
    
    override func start() {
        setFavouritesScreen()
    }
}

private extension FavouritesCoordinator {
    private func setFavouritesScreen() {
        let favouritesVM = FavouritesVM(feedService: feedService)
        let favouritesVC = FavouritesVC.instantiate(viewModel: favouritesVM)
        
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.pushViewController(favouritesVC, animated: true)
    }
}
