//
//  AddFeedVC.swift
//  rssFeed
//
//  Created by Toni Pavic on 13.12.2024..
//

import UIKit

final class AddFeedVC: UIViewController {
    
    // MARK: - Private properties
    
    private lazy var dismissButton = UIBarButtonItem(title: Strings.close, style: .plain, target: self, action: #selector (close))
    
    private lazy var urlTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Strings.FeedList.AddFeed.placeholder
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 10
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .URL
        textField.autocapitalizationType = .none
        textField.returnKeyType = .search
        textField.delegate = self
        return textField
    }()
    
    // MARK: - Class lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
    }
}

// MARK: - Private extension
private extension AddFeedVC {
    func configureSelf() {
        navigationItem.leftBarButtonItem = dismissButton
        title = viewModel.title
        self.view.backgroundColor = Colors.tertiary
        
        addSubviews()
    }
    
    func addSubviews() {
        view.addSubview(urlTextField)
        
        urlTextField.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaInsets).inset(5)
            $0.top.equalTo(view.safeAreaInsets.top).offset(55)
            $0.height.equalTo(50)
        }
    }
    
    @objc func close() {
        viewModel.didTapClose()
    }
}

// MARK: - Textfield Delegate
extension AddFeedVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        viewModel.didTapSearch(for: textField.text ?? Strings.empty)
        return true
    }
}

// MARK: - ViewModelInjectable
extension AddFeedVC: ViewModelInjectable {
    typealias ViewModel = AddFeedVMProtocol
}
