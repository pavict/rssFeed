//
//  CustomRSSFeed.swift
//  rssFeed
//
//  Created by Toni Pavic on 07.01.2025..
//

import FeedKit

public struct CustomRSSFeed {
    public let feed: RSSFeed
    public var isFavourite: Bool
    
    init(feed: RSSFeed, favourite: Bool) {
        self.feed = feed
        self.isFavourite = favourite
    }
}
