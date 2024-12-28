//
//  MainCoordinator.swift
//  rssFeed
//
//  Created by Toni Pavic on 26.11.2024..
//

import UIKit

final class MainCoordinator: Coordinator {
    
    // MARK: - Private properties
    
    private let window: UIWindow
    private lazy var mainTabBarVC = UITabBarController()
    
    private lazy var feedService: FeedServiceProtocol = FeedService(initialFeeds: nil)
    
    // MARK: - Class lifecycle
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        setupTabBarController()
    }
    
    func setupTabBarController() {
        let feedNC = UINavigationController()
        let feedCoordinator = FeedCoordinator(in: feedNC, feedService: feedService)
        push(childCoordinator: feedCoordinator)
        
        let favouritesNC = UINavigationController()
        let favouritesCoordinator = FavouritesCoordinator(navigationController: favouritesNC)
        push(childCoordinator: favouritesCoordinator)
        
        let settingsNC = UINavigationController()
        let settingsCoordinator = SettingsCoordinator(navigationController: settingsNC)
        push(childCoordinator: settingsCoordinator)
        
        self.mainTabBarVC.viewControllers = [feedNC, favouritesNC, settingsNC]
        setTabBarItems(feedNC: feedNC, favouritesNC: favouritesNC, settingsNC: settingsNC)
        
        mainTabBarVC.tabBar.tintColor = Colors.primary
        mainTabBarVC.selectedIndex = 0
        window.rootViewController = self.mainTabBarVC
    }
    
    func setTabBarItems(feedNC: UINavigationController, favouritesNC: UINavigationController, settingsNC: UINavigationController) {
        feedNC.tabBarItem = UITabBarItem(title: Strings.FeedList.title, image: UIImage(systemName: "list.bullet"), tag: 0)
        
        favouritesNC.tabBarItem = UITabBarItem(title: Strings.Favourites.title, image: UIImage(systemName: "star"), tag: 1)
        
        settingsNC.tabBarItem = UITabBarItem(title: Strings.Settings.title, image: UIImage(systemName: "gearshape"), tag: 2)
    }
}
