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

protocol AddFeedVMProtocol {
    var title: String { get }
    
    func didTapClose()
    func didTapSearch(for url: String)
}

final class AddFeedVM {
    
    // MARK: - Coordinator actions
    
    var onDidTapClose: () -> Void = { }
    var onDidTapSearch: () -> Void = { }
    
    // MARK: - Public properties
    
    lazy var state: Observable<State> = {
        return _state.asObservable().throttle(.milliseconds(5), scheduler: MainScheduler.instance)
    }()

    // MARK: - Private properties
    
    private lazy var _state = BehaviorRelay<State>(value: .loading)
    private let feedService: FeedServiceProtocol
    
    init(feedService: FeedServiceProtocol) {
        self.feedService = feedService
    }
    
    func getFeed(url: String) {
        _state.accept(.loading)
        if let url = URL(string: url) {
            let parser = FeedParser(URL: url)
            parser.parseAsync { result in
                switch result {
                case .success(let feed):
                    if let rssFeed = feed.rssFeed {
                        self.feedService.addFeed(feed: rssFeed)
                        
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
