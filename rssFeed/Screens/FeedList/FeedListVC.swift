//
//  FeedListVC.swift
//  rssFeed
//
//  Created by Toni Pavic on 26.11.2024..
//

import UIKit

final class FeedListVC: UIViewController {
    
    // MARK: - Private properties
    
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .insetGrouped)
        tv.register(FeedCell.self)
//        tv.refreshControl = self.refreshControl
        tv.dataSource = self
        tv.delegate = self
        tv.tableFooterView = UIView()
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

// MARK: - Private extension
private extension FeedListVC {
    func configureSelf() {
        title = viewModel.title
        self.view.backgroundColor = Colors.background
        
        addSubviews()
    }
    
    func addSubviews() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaInsets).inset(8)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
    }
}

// MARK: - TableView DataSource
extension FeedListVC: UITableViewDataSource {
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
extension FeedListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

// MARK: - ViewModelInjectable
extension FeedListVC: ViewModelInjectable {
    typealias ViewModel = FeedListVMProtocol
}

