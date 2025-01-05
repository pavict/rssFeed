//
//  Coordinator.swift
//  rssFeed
//
//  Created by Toni Pavic on 26.11.2024..
//

import UIKit

class Coordinator: NSObject {
    
    var shouldEnd: () -> Void = { }
    
    private(set) var coordinators = [Coordinator]()

    func push(childCoordinator: Coordinator) {
        coordinators.append(childCoordinator)
        childCoordinator.start()
    }
    
    @discardableResult
    func pop(childCoordinator: Coordinator) -> Coordinator? {
        if let index = coordinators.firstIndex(of: childCoordinator) {
            return coordinators.remove(at: index)
        } else {
            return nil
        }
    }
    
    func start() {
        // To be overriden
    }
    
    /// This method will be called before coordinator is removed from the stack.
    /// Use this method to clean view hierarchy
    func coordinatorWillEnd() {
        shouldEnd()
    }
}

// MARK: - Alert extension
extension Coordinator {
    
    func presentAlert(with message: String, in navigationController: UINavigationController, okActionCompletion: (() -> Void)? = nil) {
        print("PRESENT ALERT")
        let alert = UIAlertController(
            title: Strings.Error.alertTitle,
            message: message,
            preferredStyle: .alert
        )
        
        alert.view.tintColor = Colors.primary
        
        alert.addAction(
            UIAlertAction(
                title: Strings.ok,
                style: .default,
                handler: { _ in
                    okActionCompletion?()
                }
            )
        )
        
        navigationController.present(alert, animated: true, completion: nil)
    }
}
