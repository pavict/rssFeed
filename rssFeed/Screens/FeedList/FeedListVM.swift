//
//  FeedListVM.swift
//  rssFeed
//
//  Created by Toni Pavic on 07.12.2024..
//

protocol FeedListVMProtocol {
    var title: String { get }
    
    func numberOfItems() -> Int
}

final class FeedListVM {
    
}

extension FeedListVM: FeedListVMProtocol {
    var title: String {
        Strings.FeedList.title
    }
    
    func numberOfItems() -> Int {
        return 1
    }
}
