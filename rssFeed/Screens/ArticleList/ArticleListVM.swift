//
//  ArticleListVM.swift
//  rssFeed
//
//  Created by Toni Pavic on 28.12.2024..
//

import RxSwift
import RxRelay
import FeedKit

// MARK: - Protocol
protocol ArticleListVMProtocol {
    var state: Observable<State> { get }
    var title: String { get }
    
    func numberOfItems() -> Int
    func item(at index: Int) -> RSSFeedItem
}

final class ArticleListVM {
    
    // MARK: - Public properties
    
    lazy var state: Observable<State> = {
        return _state.asObservable().throttle(.milliseconds(5), scheduler: MainScheduler.instance)
    }()
    
    // MARK: - Private properties
    
    private lazy var _state = BehaviorRelay<State>(value: .loading)
    private let disposeBag = DisposeBag()
    private let feedTitle: String
    private let items: [RSSFeedItem]
    
    // MARK: Class lifecycle
    
    init(feed: String, items: [RSSFeedItem]) {
        self.feedTitle = feed
        self.items = items
    }
}

// MARK: - Protocol extension
extension ArticleListVM: ArticleListVMProtocol {
    
    var title: String {
        feedTitle
    }
    
    func numberOfItems() -> Int {
        items.count
    }
    
    func item(at index: Int) -> RSSFeedItem {
        items[index]
    }
}
