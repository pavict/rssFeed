//
//  AddFeedVM.swift
//  rssFeed
//
//  Created by Toni Pavic on 13.12.2024..
//

import Foundation
import RxSwift
import RxRelay
import FeedKit
import CoreData

protocol AddFeedVMProtocol {
    var state: Observable<State> { get }
    var title: String { get }
    
    func didTapClose()
    func didTapSearch(for url: String)
}

final class AddFeedVM {
    
    // MARK: - Coordinator actions
    
    var onDidTapClose: () -> Void = { }
    var onDidTapSearch: () -> Void = { }
    var onNeedsAlert: (String) -> Void = { _ in }
    
    // MARK: - Public properties
    
    lazy var state: Observable<State> = {
        return _state.asObservable().throttle(.milliseconds(5), scheduler: MainScheduler.instance)
    }()

    // MARK: - Private properties
    
    private lazy var _state = BehaviorRelay<State>(value: .empty)
    private let feedService: FeedServiceProtocol
    
    init(feedService: FeedServiceProtocol) {
        self.feedService = feedService
    }
    
    func getFeed(url: String) {
        _state.accept(.loading)
        if let url = URL(string: url) {
            let parser = FeedParser(URL: url)
            parser.parseAsync(queue: DispatchQueue.global(qos: .userInitiated)) { result in
                switch result {
                case .success(let feed):
                    
//                    switch feed {
//                    case .atom(_):
//                        if let feed = feed.atomFeed {
//                            
//                        }
//                    case .rss(_):
//                        <#code#>
//                    case .json(_):
//                        <#code#>
//                    }
                    if let rssFeed = feed.rssFeed {
                        
                        print("IMAGE?? \(rssFeed.items?[0].media?.mediaThumbnails?[0].value)")
                        let articles = rssFeed.items?.compactMap { item in
                            MyArticle(
                                name: item.title ?? Strings.empty,
                                description: item.description ?? Strings.empty,
                                link: item.link ?? Strings.empty,
                                image: item.media?.mediaThumbnails?[0].value ?? ""
                            )
                        } ?? []

                        let feed = MyRSSFeed(
                            name: rssFeed.title ?? Strings.empty,
                            image: rssFeed.image?.url ?? Strings.empty,
                            description: rssFeed.description ?? Strings.empty,
                            articles: articles
                        )
                        
                        self.feedService.addFeed(feed: feed)
//                        self.saveRSSFeed(feed: feed)
                        self._state.accept(.loaded)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        print("Error getting feed: \(error)")
                        self._state.accept(.empty)
                        self.onNeedsAlert(error.localizedDescription)
                    }
                }
            }
        } else {
            self._state.accept(.empty)
            self.onNeedsAlert(Strings.Error.invalidUrl)
        }
    }
    
//    func saveRSSFeed(feed: MyRSSFeed) {
//        print("SAVING FEED \(feed.name)")
//        let context = CoreDataManager.shared.context
//        let feedEntity = MyRSSFeedEntity(context: context)
//
//        feedEntity.name = feed.name
//        feedEntity.image = feed.image
//        feedEntity.desc = feed.description
//
//        for article in feed.articles {
//            let articleEntity = MyArticleEntity(context: context)
//            articleEntity.name = article.name
//            articleEntity.desc = article.description
//            articleEntity.link = article.link
//            articleEntity.image = article.image
//            articleEntity.feed = feedEntity
//        }
//
//        CoreDataManager.shared.saveContext()
//    }
}

// MARK: - Protocol extension
extension AddFeedVM: AddFeedVMProtocol {
    
    var title: String {
        Strings.FeedList.AddFeed.title
    }
    
    func didTapClose() {
        onDidTapClose()
    }
    
    func didTapSearch(for url: String) {
        getFeed(url: url)
    }
}
