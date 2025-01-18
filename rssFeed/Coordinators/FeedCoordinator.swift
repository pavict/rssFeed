//
//  FeedCoordinator.swift
//  rssFeed
//
//  Created by Toni Pavic on 06.12.2024..
//

import UIKit
import FeedKit

final class FeedCoordinator: Coordinator {
    
    // MARK: - Private properties
    
    private let navigationController: UINavigationController
    private let feedService: FeedServiceProtocol
    
    // MARK: - Class lifecycle
    
    init(in navigationController: UINavigationController, feedService: FeedServiceProtocol) {
        self.navigationController = navigationController
        self.feedService = feedService
    }
    
    override func start() {
        setFeedListScreen(in: navigationController)
    }
}

private extension FeedCoordinator {
    func setFeedListScreen(in navigationController: UINavigationController) {
        let feedListVM = FeedListVM(feedService: feedService)
        let feedListVC = FeedListVC.instantiate(viewModel: feedListVM)
        
        feedListVM.onAddButton = {
            self.presentAddFeedScreen(in: navigationController)
        }
        
        feedListVM.onFeedSelected = { feed in
            self.pushArticleListScreen(for: feed, in: navigationController)
        }
        
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.pushViewController(feedListVC, animated: true)
    }
    
    func presentAddFeedScreen(in navigationController: UINavigationController) {
        let addFeedVM = AddFeedVM(feedService: feedService)
        let addFeedVC = AddFeedVC.instantiate(viewModel: addFeedVM)
        let addFeedNC = UINavigationController(rootViewController: addFeedVC)
        
        addFeedVM.onDidTapClose = {
            addFeedNC.dismiss(animated: true)
        }
        
        addFeedVM.onNeedsAlert = { alert in
            self.presentAlert(with: alert, in: addFeedNC)
        }
        
        navigationController.present(addFeedNC, animated: true)
    }
    
    func pushArticleListScreen(for feed: CustomRSSFeed, in navigationController: UINavigationController) {
        let articleListVM = ArticleListVM(feed: feed.feed.title ?? Strings.empty, items: feed.feed.items ?? [])
        let articleListVC = ArticleListVC.instantiate(viewModel: articleListVM)
        
        articleListVM.onDidSelectItem = { item in
            self.openLink(url: item, in: navigationController)
        }
        
        navigationController.pushViewController(articleListVC, animated: true)
    }
}
