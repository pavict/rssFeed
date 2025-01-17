//
//  CustomRSSFeed.swift
//  rssFeed
//
//  Created by Toni Pavic on 07.01.2025..
//

import FeedKit
import RxRelay

public struct CustomRSSFeed {
    public let feed: RSSFeed
    public var isFavourite: BehaviorRelay<Bool>
    
    init(feed: RSSFeed, isFavourite: Bool = false) {
        self.feed = feed
        self.isFavourite = BehaviorRelay(value: isFavourite)
    }
}
