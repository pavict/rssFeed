//
//  ArticleWebViewVM.swift
//  rssFeed
//
//  Created by Toni Pavic on 18.01.2025..
//

import RxSwift
import RxRelay

protocol ArticleWebViewVMProtocol {
    var state: Observable<State> { get }
    var url: String { get }
    var title: String { get }
}

final class ArticleWebViewVM {
    
    // MARK: - Public properties

    lazy var state: Observable<State> = {
        return _state.asObservable().throttle(.milliseconds(5), scheduler: MainScheduler.instance)
    }()
    
    // MARK: - Private properties
    
    private lazy var _state = BehaviorRelay<State>(value: .loaded)
    private let _url: String
    
    // MARK: - Class lifecycle

    init(url: String) {
        _url = url
    }
}

// MARK: - ArticleWebViewVMProtocol
extension ArticleWebViewVM: ArticleWebViewVMProtocol {
    var url: String {
        return _url
    }
    
    var title: String {
        return Strings.empty
    }
}
