//
//  FavoritesNFTsCollectionViewCell.swift
//  FakeNFT
//
//  Created by Антон Кашников on 20/10/2023.
//

import UIKit

final class FavoritesNFTsCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "NFTCell"
    
    private let nftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame.size = CGSize(width: 80, height: 80)
        imageView.image = UIImage(named: "NFT_Placeholder")
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nftLikeView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Favorites_Active")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupNFTImageView()
        setupNFTLikeView()
        setupNFTNameLabel()
        setupRatingView()
        setupPriceLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupNFTImageView() {
        contentView.addSubview(nftImageView)
        
        NSLayoutConstraint.activate([
            nftImageView.widthAnchor.constraint(equalToConstant: 80),
            nftImageView.heightAnchor.constraint(equalToConstant: 80),
            nftImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nftImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
    }
    
    private func setupNFTLikeView() {
        nftImageView.addSubview(nftLikeView)
        
        NSLayoutConstraint.activate([
            nftLikeView.widthAnchor.constraint(equalToConstant: 42),
            nftLikeView.heightAnchor.constraint(equalToConstant: 42),
            nftLikeView.topAnchor.constraint(equalTo: nftImageView.topAnchor, constant: -6.19),
            nftLikeView.trailingAnchor.constraint(equalTo: nftImageView.trailingAnchor, constant: 6.19)
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
}
