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
    func setFavourite(at index: Int)
}

class FeedService {
    
    // MARK: - Public properties
    
    lazy var feedList: Observable<[CustomRSSFeed]?> = {
        return _feedList.asObservable()
    }()
    
    // MARK: - Private properties
    
    private lazy var _feedList = BehaviorRelay<[CustomRSSFeed]?>.init(value: nil)
    
    // MARK: - Class Lifecycle
        
    init(initialFeeds: [CustomRSSFeed]?) {
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
    
    func setFavourite(at index: Int) {
        var currentFeeds = _feedList.value ?? []
        currentFeeds[index].isFavourite.toggle()
        _feedList.accept(currentFeeds)
    }
}
