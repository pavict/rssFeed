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
        setFavouritesScreen(in: navigationController)
    }
}

private extension FavouritesCoordinator {
    private func setFavouritesScreen(in navigationController: UINavigationController) {
        let favouritesVM = FavouritesVM(feedService: feedService)
        let favouritesVC = FavouritesVC.instantiate(viewModel: favouritesVM)
        
        favouritesVM.onFeedSelected = { [weak self] feed in
            self?.pushArticleListScreen(for: feed, in: navigationController)
        }
        
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.pushViewController(favouritesVC, animated: true)
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
