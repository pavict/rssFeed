//
//  SettingsVC.swift
//  rssFeed
//
//  Created by Toni Pavic on 26.11.2024..
//

import UIKit

final class SettingsVC: UIViewController {
    
    // MARK: - Class lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
    }
}

private extension SettingsVC {
    func configureSelf() {
        title = "Settings"
        self.view.backgroundColor = .systemIndigo
    }
}

// MARK: - ViewModelInjectable
extension SettingsVC: ViewModelInjectable {
    typealias ViewModel = SettingsVMProtocol
}
