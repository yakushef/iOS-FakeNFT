//
//  FavoritesNFTsCollectionViewCell.swift
//  FakeNFT
//
//  Created by Антон Кашников on 20/10/2023.
//

import UIKit

final class FavoritesNFTsCollectionViewCell: UICollectionViewCell {
    // MARK: - Static properties
    
    static let reuseIdentifier = "NFTCell"
    
    // MARK: - UI-elements
    
    let nftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame.size = CGSize(width: 80, height: 80)
        imageView.image = UIImage(named: "NFT_Placeholder")
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nftLikeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Heart"), for: .normal)
        button.isSelected = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let nftNameLabel: UILabel = {
       let label = UILabel()
        label.text = "Lilo"
        label.font = UIFont.Bold.small
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ratingView: RatingView = {
        let ratingView = RatingView()
        ratingView.setRating(to: 4)
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        return ratingView
    }()
    
    private let priceLabel: UILabel = {
       let label = UILabel()
        label.text = "1,78 ETH"
        label.font = UIFont.Regular.medium
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Public properties
    
    var buttonTappedHandler: (() -> Void)?
    
    // MARK: - UICollectionViewCell
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupNFTImageView()
        setupNFTLikeButton()
        setupNFTNameLabel()
        setupRatingView()
        setupPriceLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func updateNameLabel(_ string: String) {
        nftNameLabel.text = string
    }
    
    func updateRating(_ int: Int) {
        ratingView.setRating(to: UInt(int))
    }
    
    func updatePrice(_ price: Double) {
        priceLabel.text = "\(price) ETH"
    }
    
    // MARK: - Private methods
    
    private func setupNFTImageView() {
        contentView.addSubview(nftImageView)
        
        NSLayoutConstraint.activate([
            nftImageView.widthAnchor.constraint(equalToConstant: 80),
            nftImageView.heightAnchor.constraint(equalToConstant: 80),
            nftImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nftImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
    }
    
    private func setupNFTLikeButton() {
        nftLikeButton.addTarget(self, action: #selector(likeButtonDidTap(_:)), for: .touchUpInside)
        nftImageView.addSubview(nftLikeButton)
        
        NSLayoutConstraint.activate([
            nftLikeButton.widthAnchor.constraint(equalToConstant: 21),
            nftLikeButton.heightAnchor.constraint(equalToConstant: 18),
            nftLikeButton.topAnchor.constraint(equalTo: nftImageView.topAnchor, constant: 5.81),
            nftLikeButton.trailingAnchor.constraint(equalTo: nftImageView.trailingAnchor, constant: -4.81)
        ])
    }
    
    private func setupNFTNameLabel() {
        contentView.addSubview(nftNameLabel)
        
        NSLayoutConstraint.activate([
            nftNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            nftNameLabel.leadingAnchor.constraint(equalTo: nftImageView.trailingAnchor, constant: 12)
        ])
    }
    
    private func setupRatingView() {
        contentView.addSubview(ratingView)
        
        NSLayoutConstraint.activate([
            ratingView.widthAnchor.constraint(equalToConstant: 68),
            ratingView.heightAnchor.constraint(equalToConstant: 12),
            ratingView.topAnchor.constraint(equalTo: nftNameLabel.bottomAnchor, constant: 4),
            ratingView.leadingAnchor.constraint(equalTo: nftNameLabel.leadingAnchor)
        ])
    }
    
    private func setupPriceLabel() {
        contentView.addSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: nftNameLabel.leadingAnchor)
        ])
    }
    
    @objc
    private func likeButtonDidTap(_ sender: UIButton) {
        buttonTappedHandler?()
    }
}
