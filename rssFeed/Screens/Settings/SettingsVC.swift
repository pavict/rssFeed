//
//  SettingsVC.swift
//  rssFeed
//
//  Created by Toni Pavic on 26.11.2024..
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SettingsVC: UIViewController {
    
    // MARK: - Private properties
    
    private let disposeBag = DisposeBag()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .insetGrouped)
        tv.register(SettingsCell.self)
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
private extension SettingsVC {
    func configureSelf() {
        title = Strings.Settings.title
        self.view.backgroundColor = Colors.tertiary
        
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
extension SettingsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(for: indexPath, type: SettingsCell.self)
        
        cell.isUserInteractionEnabled = true
        
        cell.darkModeSwitch
            .rx
            .controlEvent(.valueChanged)
            .withLatestFrom(cell.darkModeSwitch.rx.value)
            .subscribe(onNext: { bool in
                UserDefaults.standard.set(bool, forKey: "isDarkModeOn")
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first {
                    window.overrideUserInterfaceStyle = bool ? .dark : .light
                }
        }).disposed(by: disposeBag)
        
//        let item = viewModel.item(at: indexPath.row)
//        cell.configure(with: item)
        return cell
    }
}

// MARK: - TableView Delegate
extension SettingsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

// MARK: - ViewModelInjectable
extension SettingsVC: ViewModelInjectable {
    typealias ViewModel = SettingsVMProtocol
}
