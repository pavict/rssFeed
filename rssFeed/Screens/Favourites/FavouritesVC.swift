//
//  FavouritesVC.swift
//  rssFeed
//
//  Created by Toni Pavic on 26.11.2024..
//

import UIKit
import RxSwift
import Lottie

final class FavouritesVC: UIViewController {
    
    // MARK: - Private properties
    
    private let disposeBag = DisposeBag()
    
    private lazy var animationView: LottieAnimationView = {
        let view: LottieAnimationView = .init(name: Animations.favouritesEmpty)
        view.contentMode = .scaleAspectFit
        view.loopMode = .playOnce
        view.backgroundBehavior = .pauseAndRestore
        view.backgroundColor = Colors.clear
        return view
    }()
    
    private lazy var contentText = UILabel.label(with: Strings.empty, font: Fonts.body, textColor: Colors.label, textAlignment: .center)
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [animationView, contentText])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 20
        return stack
    }()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .insetGrouped)
        tv.register(FeedCell.self)
        tv.dataSource = self
        tv.delegate = self
        tv.backgroundColor = Colors.clear
        tv.rowHeight = UITableView.automaticDimension
        return tv
    }()
    
    // MARK: - Class lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
    }
}

private extension FavouritesVC {
    func configureSelf() {
        title = viewModel.title
        self.view.backgroundColor = Colors.tertiary
        
        bindObservables()
        addSubviews()
    }
    
    func bindObservables() {
        viewModel
            .state
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] state in
                switch state {
                case .loading:
                    Spinner.start()
                    break
                case .empty:
                    self.showNoDataView()
                case .loaded:
                    Spinner.stop()
                    self.tableView.reloadData()
                }
            }).disposed(by: disposeBag)
    }
    
    func addSubviews() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }
    
    func showNoDataView() {
        tableView.isHidden = true
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.centerY.equalTo(view.snp.centerY)
        }
        
        animationView.snp.makeConstraints {
            $0.size.equalTo(300)
        }
        
        contentText.text = Strings.Favourites.empty
        
        animationView.play()
    }
}

// MARK: - TableView DataSource
extension FavouritesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(for: indexPath, type: FeedCell.self)
        
//        let item = viewModel.item(at: indexPath.row)
//        cell.configure(with: item)
        return cell
    }
}

// MARK: - TableView Delegate
extension FavouritesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

// MARK: - ViewModelInjectable
extension FavouritesVC: ViewModelInjectable {
    typealias ViewModel = FavouritesVMProtocol
}
