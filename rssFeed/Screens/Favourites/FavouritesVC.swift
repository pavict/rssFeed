//
//  FavouritesVC.swift
//  rssFeed
//
//  Created by Toni Pavic on 26.11.2024..
//

import UIKit

final class FavouritesVC: UIViewController {
    
    // MARK: - Private properties
    
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
        title = "Favourites"
        self.view.backgroundColor = Colors.tertiary
        
        addSubviews()
    }
    
    func addSubviews() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
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
