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
                    if let rssFeed = feed.rssFeed {
                        let feed = CustomRSSFeed(feed: rssFeed, isFavourite: false)
                        self.feedService.addFeed(feed: feed)
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
