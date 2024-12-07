//
//  FavouritesVM.swift
//  rssFeed
//
//  Created by Toni Pavic on 07.12.2024..
//

protocol FavouritesVMProtocol {
    var title: String { get }
}

final class FavouritesVM {
    
}

extension FavouritesVM: FavouritesVMProtocol {
    var title: String {
        Strings.Favourites.title
    }
}
