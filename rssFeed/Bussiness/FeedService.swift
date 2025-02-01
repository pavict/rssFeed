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
    var feedList: Observable<[MyRSSFeed]?> { get }
    
    func addFeed(feed: MyRSSFeed)
    func deleteFeed(feed: MyRSSFeed)
    func toggleFavourite(feed: MyRSSFeed)
}

class FeedService {
    
    // MARK: - Public properties
    
    static let shared = FeedService()
    
    lazy var feedList: Observable<[MyRSSFeed]?> = {
        return _feedList.asObservable()
    }()
    
    // MARK: - Private properties
    
    private lazy var _feedList = BehaviorRelay<[MyRSSFeed]?>.init(value: nil)
    
    // MARK: - Class Lifecycle
        
    init(initialFeeds: [MyRSSFeed]? = nil) {
        _feedList.accept(initialFeeds)
    }
}

extension FeedService: FeedServiceProtocol {
    
    func addFeed(feed: MyRSSFeed) {
        var currentFeeds = _feedList.value ?? []
        currentFeeds.append(feed)
        _feedList.accept(currentFeeds)
    }
    
    func deleteFeed(feed: MyRSSFeed) {
        var currentFeeds = _feedList.value ?? []
        currentFeeds.removeAll(where: { $0.name == feed.name })
        _feedList.accept(currentFeeds)
    }
    
    func toggleFavourite(feed: MyRSSFeed) {
        feed.isFavourite.accept(!feed.isFavourite.value)
        _feedList.accept(_feedList.value)
    }
}
