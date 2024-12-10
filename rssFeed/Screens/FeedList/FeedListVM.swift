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

enum State {
    case loading
    case loaded
    case empty
    case customData
}

protocol FeedListVMProtocol {
    var state: Observable<State> { get }
    var title: String { get }
    
    func numberOfItems() -> Int
    func item(at index: Int) -> RSSFeed
}

final class FeedListVM {
    
    // MARK: - Public properties
    
    lazy var state: Observable<State> = {
        return _state.asObservable().throttle(.milliseconds(5), scheduler: MainScheduler.instance)
    }()

    
    // MARK: - Private properties
    
    private lazy var _state = BehaviorRelay<State>(value: .loading)
    private var rssFeeds: [RSSFeed] = []
    
    // MARK: Class lifecycle
    
    init() {
        getFeed()
    }
}

// MARK: - Private extension
private extension FeedListVM {
    
    func getFeed() {
        _state.accept(.loading)
        if let url = URL(string: "https://www.cbc.ca/webfeed/rss/rss-world") {
            let parser = FeedParser(URL: url)
            parser.parseAsync { result in
                switch result {
                case .success(let feed):
                    if let rssFeed = feed.rssFeed {
                        self.rssFeeds.append(rssFeed)
                        for item in rssFeed.items ?? [] {
                            print("Item Title: \(item.title ?? "")")
                        }
                    }
                    self._state.accept(.loaded)
                case .failure(let error):
                    self._state.accept(.empty)
                    print("Error: \(error)")
                }
            }
        }
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
}
