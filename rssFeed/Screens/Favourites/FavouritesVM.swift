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
    func item(at index: Int) -> MyRSSFeed
    func didTapFeed(at index: Int)
}

final class FavouritesVM {
    
    // MARK: - Coordinator actions
    
    var onFeedSelected: (MyRSSFeed) -> Void = { _ in }
    
    // MARK: - Public properties
    
    lazy var state: Observable<State> = {
        return _state.asObservable().throttle(.milliseconds(5), scheduler: MainScheduler.instance)
    }()
    
    // MARK: - Private properties
    
    private lazy var _state = BehaviorRelay<State>(value: .loading)
    private let disposeBag = DisposeBag()
    private let feedService: FeedServiceProtocol
    private var rssFeeds: [MyRSSFeed] = []
    
    // MARK: Class lifecycle
    
    init(feedService: FeedServiceProtocol) {
        self.feedService = feedService
        
        bindService()
    }
}

private extension FavouritesVM {
    func bindService() {
        feedService
            .feedList
            .map { feedList in
                feedList?.filter { $0.isFavourite.value } ?? []
            }
            .subscribe(onNext: { [weak self] favouritesFeed in
                if favouritesFeed.isEmpty {
                    self?._state.accept(.empty)
                } else {
                    self?.rssFeeds = favouritesFeed
                    self?._state.accept(.loaded)
                }
        }).disposed(by: disposeBag)
    }
}

extension FavouritesVM: FavouritesVMProtocol {
    
    var title: String {
        Strings.Favourites.title
    }
    
    func numberOfItems() -> Int {
        return rssFeeds.count
    }
    
    func item(at index: Int) -> MyRSSFeed {
        return rssFeeds[index]
    }
    
    func didTapFeed(at index: Int) {
        onFeedSelected(rssFeeds[index])
    }
}
