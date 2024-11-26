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
    
    // MARK: - Class lifecycle
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        setuptabBarController()
    }
    
    func setuptabBarController() {
        mainTabBarVC.viewControllers = [
            UINavigationController(rootViewController: FeedListVC()),
            UINavigationController(rootViewController: FavouritesVC()),
            UINavigationController(rootViewController: SettingsVC())
        ]
        
        mainTabBarVC.selectedIndex = 0
        window.rootViewController = self.mainTabBarVC
    }
}
