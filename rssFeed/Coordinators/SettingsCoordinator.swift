//
//  SettingsCoordinator.swift
//  rssFeed
//
//  Created by Toni Pavic on 06.12.2024..
//

import UIKit

final class SettingsCoordinator: Coordinator {
    
    // MARK: - Private properties
    
    private let navigationController: UINavigationController
    
    // MARK: - Class lifecycle
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        setSettingsScreen()
    }
}

private extension SettingsCoordinator {
    private func setSettingsScreen() {
        let settingsVM = SettingsVM()
        let settingsVC = SettingsVC.instantiate(viewModel: settingsVM)
        
        navigationController.pushViewController(settingsVC, animated: true)
    }
}
