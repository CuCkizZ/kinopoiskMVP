//
//  CustomTableViewCell.swift
//  MVP
//
//  Created by Nikita Beglov on 29.05.2024.
//

import UIKit
import SnapKit

final class MainTableViewCell: UITableViewCell {
    
    private lazy var nameLabel = UILabel()
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [posterImageView, nameLabel])
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 10
        stackView.layoutMargins =  UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        nameLabel.numberOfLines = 0
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
    }
    
    func configuration(with model: CellModel) {
        nameLabel.text = model.title
        if let url = model.posterImage {
            posterImageView.load(url: url)
        } else {
            return
        }
    }
    
//    MARK: Private methods
    
    private func setupView() {
        contentView.addSubview(stackView)
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        posterImageView.snp.makeConstraints { make in
            make.height.equalTo(150)
            make.width.equalTo(90)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
        }
    }
}
