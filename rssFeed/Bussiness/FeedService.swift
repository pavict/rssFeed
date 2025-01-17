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
    var feedList: Observable<[CustomRSSFeed]?> { get }
    
    func addFeed(feed: CustomRSSFeed)
    func deleteFeed(feed: RSSFeed)
    func toggleFavourite(feed: CustomRSSFeed)
}

class FeedService {
    
    // MARK: - Public properties
    
    static let shared = FeedService()
    
    lazy var feedList: Observable<[CustomRSSFeed]?> = {
        return _feedList.asObservable()
    }()
    
    // MARK: - Private properties
    
    private lazy var _feedList = BehaviorRelay<[CustomRSSFeed]?>.init(value: nil)
    
    // MARK: - Class Lifecycle
        
    init(initialFeeds: [CustomRSSFeed]? = nil) {
        _feedList.accept(initialFeeds)
    }
}

extension FeedService: FeedServiceProtocol {
    
    func addFeed(feed: CustomRSSFeed) {
        var currentFeeds = _feedList.value ?? []
        currentFeeds.append(feed)
        _feedList.accept(currentFeeds)
    }
    
    func deleteFeed(feed: RSSFeed) {
        var currentFeeds = _feedList.value ?? []
        currentFeeds.removeAll(where: { $0.feed == feed })
        _feedList.accept(currentFeeds)
    }
    
    func toggleFavourite(feed: CustomRSSFeed) {
        feed.isFavourite.accept(!feed.isFavourite.value)
        _feedList.accept(_feedList.value)
    }
}
