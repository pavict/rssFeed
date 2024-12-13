//
//  AddFeedVM.swift
//  rssFeed
//
//  Created by Toni Pavic on 13.12.2024..
//

protocol AddFeedVMProtocol {
    var title: String { get }
    
    func didTapClose()
}

final class AddFeedVM {
    
    // MARK: - Coordinator actions
    var onDidTapClose: () -> Void = { }
    
    init() {
        
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
}
