//
//  FeedCell.swift
//  rssFeed
//
//  Created by Toni Pavic on 07.12.2024..
//

import UIKit
import SnapKit

final class FeedCell: UITableViewCell, ReusableView {
    
    // MARK: - Private properties
    private lazy var feedNameLabel = UILabel.label(with: "RSS FEED NAME", font: Fonts.title2, textColor: Colors.black, textAlignment: .natural)
    
    private lazy var descriptionLabel = UILabel.label(with: "This is a description of the feed.", font: Fonts.body, textColor: Colors.black, textAlignment: .natural)
    
    private lazy var feedImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = .rssFeedIcon
        return image
    }()
    
    private lazy var textStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [feedNameLabel, descriptionLabel])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .equalCentering
        stack.spacing = 10
        return stack
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [feedImageView, textStackView])
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 0
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

private extension FeedCell {
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
