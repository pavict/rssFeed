//
//  ArticleCell.swift
//  rssFeed
//
//  Created by Toni Pavic on 28.12.2024..
//

import FeedKit
import UIKit

final class ArticleCell: UITableViewCell, ReusableView {
    
    // MARK: - Private properties
    
    private lazy var nameLabel = UILabel.label(with: Strings.empty, font: Fonts.title2, textColor: Colors.primary, textAlignment: .natural)
    
    private lazy var descriptionLabel = UILabel.label(with: Strings.empty, font: Fonts.body, textColor: Colors.label, textAlignment: .left)
    
    private lazy var feedImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = .rssFeedIcon
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var textStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, descriptionLabel])
        stack.axis = .vertical
        stack.alignment = .top
        stack.distribution = .fill
        stack.spacing = 10
        return stack
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [feedImageView, textStackView])
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
private extension ArticleCell {
    func addSubviews() {
        contentView.addSubview(contentStackView)
        
        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
            $0.right.equalToSuperview().inset(20)
        }
        
        let imageWidth: CGFloat = 130
        feedImageView.snp.makeConstraints {
            $0.size.height.equalTo(imageWidth)
        }
    }
}

extension ArticleCell {
    func configure(with article: RSSFeedItem) {
        nameLabel.text = article.title
        descriptionLabel.text = article.description
    }
}
