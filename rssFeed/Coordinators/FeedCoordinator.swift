//
//  FeedCoordinator.swift
//  rssFeed
//
//  Created by Toni Pavic on 06.12.2024..
//

import UIKit

final class FeedCoordinator: Coordinator {
    
    // MARK: - Private properties
    
    private let navigationController: UINavigationController
    
    // MARK: - Class lifecycle
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        setFeedListScreen()
    }
}

private extension FeedCoordinator {
    private func setFeedListScreen() {
        let feedListVM = FeedListVM()
        let feedListVC = FeedListVC.instantiate(viewModel: feedListVM)
        
        feedListVM.onAddButton = {
            print("did tap add")
//            navigationController.present(, animated: true)
        }
        
        navigationController.pushViewController(feedListVC, animated: true)
    }
}
