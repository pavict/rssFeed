//
//  SettingsVM.swift
//  rssFeed
//
//  Created by Toni Pavic on 07.12.2024..
//

protocol SettingsVMProtocol {
    var title: String { get }
    
    func numberOfItems() -> Int
}

final class SettingsVM {
    
}

extension SettingsVM: SettingsVMProtocol {
    var title: String {
        Strings.Settings.title
    }
    
    func numberOfItems() -> Int {
        return 1
    }
}
