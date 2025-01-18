//
//  SettingsCell.swift
//  rssFeed
//
//  Created by Toni Pavic on 09.12.2024..
//

import UIKit
import SnapKit

final class SettingsCell: UITableViewCell, ReusableView {
    
    // MARK: - Private properties
    
    private lazy var notificationsLabel = UILabel.label(with: Strings.Settings.notifications, font: Fonts.title3, textColor: Colors.label, textAlignment: .natural)
    
    private lazy var notificationsSwitch: UISwitch = {
        let switchView = UISwitch()
        switchView.isOn = true
        switchView.onTintColor = Colors.primary
        switchView.setContentHuggingPriority(.required, for: .horizontal)
        return switchView
    }()
    
    private lazy var notificationsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [notificationsLabel, notificationsSwitch])
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = UIStackView.spacingUseSystem
        return stack
    }()
    
    private lazy var linkExternalLabel = UILabel.label(with: Strings.Settings.linkExternal, font: Fonts.title3, textColor: Colors.label, textAlignment: .natural)
    
    lazy var linkExternalSwitch: UISwitch = {
        let switchView = UISwitch()
        switchView.isOn = true
        switchView.onTintColor = Colors.primary
        switchView.setContentHuggingPriority(.required, for: .horizontal)
        return switchView
    }()
    
    private lazy var linkExternalStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [linkExternalLabel, linkExternalSwitch])
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = UIStackView.spacingUseSystem
        return stack
    }()
    
    private lazy var darkModeLabel = UILabel.label(with: Strings.Settings.darkMode, font: Fonts.title3, textColor: Colors.label, textAlignment: .natural)
    
    lazy var darkModeSwitch: UISwitch = {
        let switchView = UISwitch()
        switchView.isOn = true
        switchView.onTintColor = Colors.primary
        switchView.setContentHuggingPriority(.required, for: .horizontal)
        return switchView
    }()
    
    private lazy var darkModeStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [darkModeLabel, darkModeSwitch])
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = UIStackView.spacingUseSystem
        return stack
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [notificationsStackView, linkExternalStackView, darkModeStackView])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 30
        return stack
    }()
    
    // MARK: - Class lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSelf()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

// MARK: - Private extension
private extension SettingsCell {
    
    func configureSelf() {
        selectionStyle = .none
        
        addSubviews()
    }
    
    func addSubviews() {
        contentView.addSubview(contentStackView)
        
        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
        
        configureNotificationSwitch()
        configureLinkExternalSwitch()
        configureDarkModeSwitch()
    }
    
    func configureNotificationSwitch() {
        notificationsSwitch.isOn = UserDefaults.standard.bool(forKey: "NotificationSwitch")
    }
    
    func configureLinkExternalSwitch() {
        linkExternalSwitch.isOn = UserDefaults.standard.bool(forKey: "isLinkExternalOn")
    }
    
    func configureDarkModeSwitch() {
        darkModeSwitch.isOn = UserDefaults.standard.bool(forKey: "isDarkModeOn")
        switch self.traitCollection.userInterfaceStyle {
        case .unspecified, .light:
            darkModeSwitch.isOn = false
        case .dark:
            darkModeSwitch.isOn = true
        @unknown default:
            darkModeSwitch.isOn = false
        }
    }
}
