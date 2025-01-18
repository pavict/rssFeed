//
//  ArticleWebViewVC.swift
//  rssFeed
//
//  Created by Toni Pavic on 18.01.2025..
//

import UIKit
import WebKit
import RxSwift

final class ArticleWebViewVC: UIViewController {
    
    // MARK: - Private properties
    
    private let disposeBag = DisposeBag()
    
    private lazy var backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(goBack))
    private lazy var forwardButton = UIBarButtonItem(image: UIImage(systemName: "chevron.forward"), style: .plain, target: self, action: #selector(goForward))
    
    private lazy var webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        webView.allowsLinkPreview = true
        return webView
    }()
    
    // MARK: - Class lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        bindVM()
        configureViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setToolbarHidden(true, animated: true)
    }
}

// MARK: - Private extension
private extension ArticleWebViewVC {
    func configureViews() {
        configureSelf()
        configureWebView()
        configureToolbar()
    }
    
    func configureSelf() {
        self.title = viewModel.title
        hidesBottomBarWhenPushed = true
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.setToolbarHidden(false, animated: true)
    }

    func configureToolbar() {
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbarItems = [backButton, flexibleSpace, forwardButton]
    }

    func configureWebView() {
        view.addSubview(webView)
        
        webView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func bindVM() {
        let urlRequest = URLRequest(url: URL(string: viewModel.url)!)
        webView.load(urlRequest)

        viewModel
            .state
            .asDriver(onErrorJustReturn: .empty)
            .drive(onNext: { state in
                switch state {
                case .loading:
                    Spinner.start()
                default:
                    Spinner.stop()
                }
                }).disposed(by: disposeBag)
    }
    
    @objc func goForward() {
        if webView.canGoForward { webView.goForward() }
    }

    @objc func goBack() {
        if webView.canGoBack { webView.goBack() }
    }
}

// MARK: - WKNavigationDelegate
extension ArticleWebViewVC: WKNavigationDelegate {
}

// MARK: - WKUIDelegate
extension ArticleWebViewVC: WKUIDelegate { }

// MARK: - ViewModelInjectable
extension ArticleWebViewVC: ViewModelInjectable {
    typealias ViewModel = ArticleWebViewVMProtocol
}
