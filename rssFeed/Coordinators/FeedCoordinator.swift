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
    func setFeedListScreen() {
        let feedListVM = FeedListVM()
        let feedListVC = FeedListVC.instantiate(viewModel: feedListVM)
        
        feedListVM.onAddButton = {
            self.presentAddFeedScreen(in: self.navigationController)
        }
        
        navigationController.pushViewController(feedListVC, animated: true)
    }
    
    func presentAddFeedScreen(in navigationController: UINavigationController) {
        let addFeedVM = AddFeedVM()
        let addFeedVC = AddFeedVC.instantiate(viewModel: addFeedVM)
        let addFeedNC = UINavigationController(rootViewController: addFeedVC)
        
        addFeedVM.onDidTapClose = {
            addFeedNC.dismiss(animated: true)
        }
        
        navigationController.present(addFeedNC, animated: true)
    }
}
