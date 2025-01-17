//
//  NavigationBar.swift
//  rssFeed
//
//  Created by Toni Pavic on 04.01.2025..
//

import UIKit

final class Theme {
    func setupNavBarAppearance() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: Colors.primary]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: Colors.primary]
        navBarAppearance.backgroundColor =  Colors.tertiary
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().tintColor = Colors.primary
    }
}
