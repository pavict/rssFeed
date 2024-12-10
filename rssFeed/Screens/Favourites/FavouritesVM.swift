//
//  FavouritesVM.swift
//  rssFeed
//
//  Created by Toni Pavic on 07.12.2024..
//

import RxSwift
import RxRelay

protocol FavouritesVMProtocol {
    var state: Observable<State> { get }
    var title: String { get }
    
    func numberOfItems() -> Int
}

final class FavouritesVM {
    
    // MARK: - Public properties
    
    lazy var state: Observable<State> = {
        return _state.asObservable().throttle(.milliseconds(5), scheduler: MainScheduler.instance)
    }()
    
    // MARK: - Private properties
    
    private lazy var _state = BehaviorRelay<State>(value: .loading)
    
    // MARK: Class lifecycle
    
    init() {
        _state.accept(.empty)
    }
}

extension FavouritesVM: FavouritesVMProtocol {
    var title: String {
        Strings.Favourites.title
    }
    
    func numberOfItems() -> Int {
        return 1
    }
}
