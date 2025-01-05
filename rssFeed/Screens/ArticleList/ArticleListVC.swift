//
//  ArticleListVC.swift
//  rssFeed
//
//  Created by Toni Pavic on 28.12.2024..
//

import UIKit

final class ArticleListVC: UIViewController {
    
    // MARK: - Private properties
    
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .insetGrouped)
        tv.register(ArticleCell.self)
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

// MARK: - Private extension
private extension ArticleListVC {
    func configureSelf() {
        title = viewModel.title
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
extension ArticleListVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(for: indexPath, type: ArticleCell.self)
        let item = viewModel.item(at: indexPath.section)
        cell.configure(with: item)
        return cell
    }
}

// MARK: - TableView Delegate
extension ArticleListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

// MARK: - ViewModelInjectable
extension ArticleListVC: ViewModelInjectable {
    typealias ViewModel = ArticleListVMProtocol
}
