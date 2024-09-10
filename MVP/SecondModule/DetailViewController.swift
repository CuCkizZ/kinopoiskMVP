//
//  DetailViewController.swift
//  MVP
//
//  Created by Nikita Beglov on 24.05.2024.
//

import SnapKit
import UIKit

final class DetailViewController: UIViewController {
    
    var presenter: DetailPresenterProtocol?
    
    private lazy var strFirstRatingLabel = UILabel()
    private lazy var intFirstRatingLabel = UILabel()
    private lazy var strSecondRatingLabel = UILabel()
    private lazy var intSecondRatingLabel = UILabel()
    
    private lazy var ratingStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            strFirstRatingLabel,
            intFirstRatingLabel,
            strSecondRatingLabel,
            intSecondRatingLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var posterImage: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 70, height: 200))
        return imageView
    }()
    
    // MARK: - Description Views
    private lazy var nameRuLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var nameOriginalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.defaultGrayFonzSize)
        label.textColor = .gray
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.defaultBlackFonzSize)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        return label
    }()
    
    private lazy var strYearLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: Constants.defaultGrayFonzSize)
        return label
    }()
    
    private lazy var intYearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.defaultBlackFonzSize)
        return label
    }()
    
    private lazy var strTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: Constants.defaultGrayFonzSize)
        return label
    }()
    
    private lazy var intTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.defaultBlackFonzSize)
        return label
    }()
    
    // MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupViews()
        setupConstraints()
    }
}

// MARK: Private methods

private extension DetailViewController {
    
    func setupViews() {
        view.addSubview(ratingStackView)
        view.addSubview(posterImage)
        view.addSubview(nameRuLabel)
        view.addSubview(nameOriginalLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(strYearLabel)
        view.addSubview(intYearLabel)
        view.addSubview(strTimeLabel)
        view.addSubview(intTimeLabel)
    }
    
    func setupConstraints() {
        ratingStackView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.top.equalToSuperview().inset(30)
            make.right.equalToSuperview().inset(Constants.defaultInset)
        }
        posterImage.snp.makeConstraints { make in
            make.height.equalTo(300)
            make.width.equalTo(200)
            make.top.equalToSuperview().inset(30)
            make.left.equalToSuperview().inset(Constants.defaultInset)
        }
        nameRuLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImage.snp.bottom).inset(-Constants.defaultInset)
            make.centerX.equalToSuperview()
        }
        nameOriginalLabel.snp.makeConstraints { make in
            make.top.equalTo(nameRuLabel.snp.bottom)
            make.centerX.equalToSuperview()
        }
        descriptionLabel.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.top.equalTo(nameOriginalLabel.snp.bottom).inset(-Constants.defaultInset)
            make.left.equalToSuperview().inset(Constants.defaultInset)
        }
        strYearLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).inset(-20)
            make.left.equalToSuperview().inset(Constants.defaultInset)
        }
        intYearLabel.snp.makeConstraints { make in
            make.top.equalTo(strYearLabel.snp.bottom)
            make.left.equalToSuperview().inset(Constants.defaultInset)
        }
        strTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(intYearLabel.snp.bottom).inset(-30)
            make.left.equalToSuperview().inset(Constants.defaultInset)
        }
        intTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(strTimeLabel.snp.bottom)
            make.left.equalToSuperview().inset(Constants.defaultInset)
        }
    }
}

//    MARK: ConfigureUI(Protocol)

extension DetailViewController: DetailViewProtocol {
    
    func configure(_ model: FullInfo) {
        strFirstRatingLabel.text = Constants.raitingKinopoisk
        intFirstRatingLabel.text = String(describing: model.ratingKinopoisk)
        strSecondRatingLabel.text = Constants.raitingMIMDB
        intSecondRatingLabel.text = String(describing: model.ratingImdb)
        nameRuLabel.text = model.nameRu
        nameOriginalLabel.text = model.nameOriginal
        descriptionLabel.text = model.description
        strYearLabel.text = Constants.year
        intYearLabel.text = String(describing: model.year)
        strTimeLabel.text = Constants.filmLenght
        intTimeLabel.text = String(describing: model.filmLength)
        guard let url = model.posterUrl else { return }
        posterImage.load(url: url)
    }
}

private enum Constants {
    
        static let raitingKinopoisk: String = "Kinopoisk"
        static let raitingMIMDB: String = "IMDB"
        static let year: String = "Год производства"
        static let filmLenght: String = "Продолжительность"

        static let defaultInset: Int = 32
        static let defaultBlackFonzSize: CGFloat = 15
        static let defaultGrayFonzSize: CGFloat = 12
}
