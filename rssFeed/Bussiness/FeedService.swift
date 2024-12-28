//
//  FeedService.swift
//  rssFeed
//
//  Created by Toni Pavic on 28.12.2024..
//

import FeedKit
import RxSwift
import RxRelay

protocol FeedServiceProtocol {
    var feedList: Observable<[RSSFeed]?> { get }
    
    func addFeed(feed: RSSFeed)
}

class FeedService {
    
    // MARK: - Public properties
    
    lazy var feedList: Observable<[RSSFeed]?> = {
        return _feedList.asObservable()
    }()
    
    // MARK: - Private properties
    
    private lazy var _feedList = BehaviorRelay<[RSSFeed]?>.init(value: nil)
    
    // MARK: - Class Lifecycle
        
    init(initialFeeds: [RSSFeed]?) {
        _feedList.accept(initialFeeds)
    }
}

extension FeedService: FeedServiceProtocol {
    
    func addFeed(feed: RSSFeed) {
        var currentFeeds = _feedList.value ?? []
        currentFeeds.append(feed)
        _feedList.accept(currentFeeds)
    }
}
