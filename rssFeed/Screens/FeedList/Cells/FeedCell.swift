//
//  FeedCell.swift
//  rssFeed
//
//  Created by Toni Pavic on 07.12.2024..
//

import UIKit
import SnapKit
import FeedKit
import SDWebImage
import Lottie
import RxSwift

final class FeedCell: UITableViewCell, ReusableView {
    
    // MARK: - Public properties
    
    var onFavouriteSelected: () -> Void = { }
    
    // MARK: - Private properties
    
    private var disposeBag = DisposeBag()
    
    private lazy var feedNameLabel = UILabel.label(with: Strings.empty, font: Fonts.title2, textColor: Colors.primary, textAlignment: .natural, lineBreakMode: .byTruncatingTail)
    
    private lazy var descriptionLabel = UILabel.label(with: Strings.empty, font: Fonts.body, textColor: Colors.label, textAlignment: .left)
    
    private lazy var feedImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = .rssFeedIcon
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var favouriteButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "star"), for: .normal)
        btn.tintColor = Colors.primary
        btn.contentMode = .scaleAspectFit
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(favouriteButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var headerStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [feedImageView, textStackView])
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 10
        return stack
    }()
    
    private lazy var textStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [feedNameLabel, favouriteButton])
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 20
        return stack
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [headerStackView, descriptionLabel])
        stack.axis = .vertical
        stack.alignment = .top
        stack.distribution = .fill
        stack.spacing = 20
        return stack
    }()
    
    // MARK: - Class lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

// MARK: - Private extension
private extension FeedCell {
    func addSubviews() {
        contentView.addSubview(contentStackView)
        
        contentStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.top.bottom.trailing.equalToSuperview().inset(20)
        }
        
        let favouriteWidth: CGFloat = 30
        favouriteButton.snp.makeConstraints {
            $0.size.height.equalTo(favouriteWidth)
        }
        
        let imageWidth: CGFloat = 130
        feedImageView.snp.makeConstraints {
            $0.size.height.equalTo(imageWidth)
        }
    }
    
    func bindObservers(for feed: MyRSSFeed) {
        feed.isFavourite
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isFavourite in
                let favouriteIcon = isFavourite ? "star.fill" : "star"
                self?.favouriteButton.setImage(UIImage(systemName: favouriteIcon), for: .normal)
            })
            .disposed(by: disposeBag)
    }
    
    @objc func favouriteButtonTapped() {
        onFavouriteSelected()
    }
}

// MARK: - Public extension
extension FeedCell {
    func configure(with feed: MyRSSFeed, shouldShowFavouriteButton: Bool) {
        feedNameLabel.text = feed.name
        descriptionLabel.text = feed.description
        feedImageView.sd_setImage(with: URL(string: feed.image), placeholderImage: .rssFeedIcon)
        favouriteButton.isHidden = !shouldShowFavouriteButton
        
        bindObservers(for: feed)
    }
}
