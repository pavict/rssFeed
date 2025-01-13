//
//  AddFeedVC.swift
//  rssFeed
//
//  Created by Toni Pavic on 13.12.2024..
//

import UIKit
import Lottie
import RxSwift

final class AddFeedVC: UIViewController {
    
    // MARK: - Private properties
    
    private let disposeBag = DisposeBag()
    
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
        textField.addClearButton()
        return textField
    }()
    
    private lazy var animationView: LottieAnimationView = {
        let view: LottieAnimationView = .init(name: Animations.added)
        view.contentMode = .scaleAspectFit
        view.loopMode = .playOnce
        view.animationSpeed = 1.2
        view.backgroundColor = Colors.clear
        return view
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
        animationView.isHidden = true
        
        bindObservables()
        addSubviews()
    }
    
    func addSubviews() {
        view.addSubview(urlTextField)
        view.addSubview(animationView)
        
        urlTextField.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaInsets).inset(5)
            $0.top.equalTo(view.safeAreaInsets.top).offset(55)
            $0.height.equalTo(50)
        }
        
        animationView.snp.makeConstraints {
            $0.top.equalTo(urlTextField.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(400)
        }
    }
    
    func bindObservables() {
        viewModel
            .state
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] state in
                switch state {
                case .loading:
                    Spinner.start()
                case .loaded:
                    Spinner.stop()
                    self.handleAddedFeed()
                case .empty:
                    Spinner.stop()
                }
            }).disposed(by: disposeBag)
    }
    
    @objc func close() {
        viewModel.didTapClose()
    }
    
    func handleAddedFeed() {
        
        animationView.isHidden = false
        
        animationView.play { [weak self] finished in
            if finished {
                
                let fbGen = UIImpactFeedbackGenerator(style: .heavy)
                fbGen.impactOccurred()
                self?.dismiss(animated: true, completion: nil)
            }
        }
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
