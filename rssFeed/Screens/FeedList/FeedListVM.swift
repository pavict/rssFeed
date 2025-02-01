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
import CoreData

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
    func item(at index: Int) -> MyRSSFeed
    func deleteItem(at index: Int)
    func didTapAddButton()
    func didTapFeed(at index: Int)
    func toggleFavourite(feed: MyRSSFeed)
}

final class FeedListVM {
    
    // MARK: - Coordinator actions
    
    var onAddButton: () -> Void = { }
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
        
        fetchSavedFeeds()
        bindService()
    }
    
    func fetchSavedFeeds() {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<MyRSSFeedEntity> = MyRSSFeedEntity.fetchRequest()

        do {
            let savedFeeds = try context.fetch(fetchRequest)
            for feed in savedFeeds {
                print("Name: \(feed.name ?? "No name")")
                print("Image: \(feed.image ?? "No image")")
                print("Description: \(feed.desc ?? "No description")")
                
                if let articles = feed.articles as? Set<MyArticleEntity> {
                    for article in articles {
                        print("    Article Name: \(article.name ?? "No article name")")
                    }
                }
            }
        } catch {
            print("Error fetching data: \(error)")
        }
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
    
    func item(at index: Int) -> MyRSSFeed {
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
    
    func toggleFavourite(feed: MyRSSFeed) {
        feedService.toggleFavourite(feed: feed)
    }
}
