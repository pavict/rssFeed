//
//  CustomRSSFeed.swift
//  rssFeed
//
//  Created by Toni Pavic on 07.01.2025..
//

import FeedKit
import RxRelay
import CoreData

public struct CustomRSSFeed {
    public let feed: RSSFeed
    public var isFavourite: BehaviorRelay<Bool>
    
    init(feed: RSSFeed, isFavourite: Bool = false) {
        self.feed = feed
        self.isFavourite = BehaviorRelay(value: isFavourite)
    }
}

public struct MyRSSFeed {
    public let name: String
    public let image: String
    public let description: String
    public var isFavourite: BehaviorRelay<Bool>
    public let articles: [MyArticle]
    
    public init(name: String, image: String, description: String, isFavourite: Bool = false, articles: [MyArticle]) {
        self.name = name
        self.image = image
        self.description = description
        self.isFavourite = BehaviorRelay(value: isFavourite)
        self.articles = articles
    }
}

public struct MyArticle {
    public let name: String
    public let description: String
    public let link: String
    public let image: String?
    
    public init(name: String, description: String, link: String, image: String? = nil) {
        self.name = name
        self.description = description
        self.link = link
        self.image = image
    }
}
