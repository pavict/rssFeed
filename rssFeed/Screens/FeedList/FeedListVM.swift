//
//  FeedListVM.swift
//  rssFeed
//
//  Created by Toni Pavic on 07.12.2024..
//

import Foundation
import FeedKit
import RxSwift
import RxRelay

// MARK: - State enum
enum State {
    case loading
    case loaded
    case empty
}

// MARK: - Protocol
protocol FeedListVMProtocol {
    var state: Observable<State> { get }
    var title: String { get }
    
    func numberOfItems() -> Int
    func item(at index: Int) -> RSSFeed
    func deleteItem(at index: Int)
    func didTapAddButton()
    func didTapFeed(at index: Int)
}

final class FeedListVM {
    
    // MARK: - Coordinator actions
    
    var onAddButton: () -> Void = { }
    var onFeedSelected: (RSSFeed) -> Void = { _ in }
    
    // MARK: - Public properties
    
    lazy var state: Observable<State> = {
        return _state.asObservable().throttle(.milliseconds(5), scheduler: MainScheduler.instance)
    }()

    // MARK: - Private properties
    
    private lazy var _state = BehaviorRelay<State>(value: .loading)
    private let disposeBag = DisposeBag()
    private let feedService: FeedServiceProtocol
    private var rssFeeds: [RSSFeed] = []
    
    // MARK: Class lifecycle
    
    init(feedService: FeedServiceProtocol) {
        self.feedService = feedService
        
        bindService()
    }
}

// MARK: - Private extension
private extension FeedListVM {
    
    func bindService() {
        feedService
            .feedList
            .subscribe(onNext: { [weak self] feedList in
                if let feeds = feedList {
                    if feeds.isEmpty {
                        self?._state.accept(.empty)
                    } else {
                        self?.rssFeeds = feeds
                        self?._state.accept(.loaded)
                    }
                } else {
                    self?._state.accept(.empty)
                }
        }).disposed(by: disposeBag)
    }
}

// MARK: - Protocol extension
extension FeedListVM: FeedListVMProtocol {
    
    var title: String {
        Strings.FeedList.title
    }
    
    func numberOfItems() -> Int {
        rssFeeds.count
    }
    
    func item(at index: Int) -> RSSFeed {
        rssFeeds[index]
    }
    
    func deleteItem(at index: Int) {
        feedService.deleteFeed(feed: rssFeeds[index])
    }
    
    func didTapAddButton() {
        onAddButton()
    }
    
    func didTapFeed(at index: Int) {
        onFeedSelected(rssFeeds[index])
    }
}
