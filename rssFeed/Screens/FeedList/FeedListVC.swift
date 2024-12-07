//
//  FeedListVC.swift
//  rssFeed
//
//  Created by Toni Pavic on 26.11.2024..
//

import UIKit

final class FeedListVC: UIViewController {
    
    // MARK: - Class lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
    }
}

private extension FeedListVC {
    func configureSelf() {
        title = viewModel.title
        self.view.backgroundColor = .cyan
    }
}

// MARK: - ViewModelInjectable
extension FeedListVC: ViewModelInjectable {
    typealias ViewModel = FeedListVMProtocol
}
