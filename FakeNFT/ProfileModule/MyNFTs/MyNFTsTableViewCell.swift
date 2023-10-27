//
//  MyNFTsTableViewCell.swift
//  FakeNFT
//
//  Created by Антон Кашников on 19/10/2023.
//

import UIKit

final class MyNFTsTableViewCell: UITableViewCell {
    static let reuseIdentifier = "NFTCell"

    private let nftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "NFT_Placeholder")
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nftLikeView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Favorites_Inactive")
        return imageView
    }()
    
    private let containerView = UIView()
    
    private let nftNameLabel: UILabel = {
       let label = UILabel()
        label.text = "Lilo"
        label.font = UIFont.Bold.small
        return label
    }()
    
    private let ratingView: RatingView = {
        let ratingView = RatingView()
        ratingView.setRating(to: 4)
        return ratingView
    }()
    
    private let nftAuthorLabel: UILabel = {
       let label = UILabel()
        label.text = "от John Doe"
        label.font = UIFont.Regular.small
        return label
    }()
    
    private let priceTitleLabel: UILabel = {
       let label = UILabel()
        label.text = "Цена"
        label.font = UIFont.Regular.small
        return label
    }()
    
    private let priceLabel: UILabel = {
       let label = UILabel()
        label.text = "1,78 ETH"
        label.font = UIFont.Bold.small
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupNFTImageView()
        setupNFTLikeView()
        setupContainerView()
        setupNFTNameLabel()
        setupRatingView()
        setupNFTAuthorLabel()
        setupPriceTitleLabel()
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
    
    func updateAuthor(_ author: String) {
        nftAuthorLabel.text = "от \(author)"
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        [
            nftImageView,
            nftLikeView,
            containerView,
            nftNameLabel,
            ratingView,
            nftAuthorLabel,
            priceTitleLabel,
            priceLabel
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupNFTImageView() {
        contentView.addSubview(nftImageView)
        
        NSLayoutConstraint.activate([
            nftImageView.widthAnchor.constraint(equalToConstant: 108),
            nftImageView.heightAnchor.constraint(equalToConstant: 108),
            nftImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            nftImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
    }
    
    private func setupNFTLikeView() {
        nftImageView.addSubview(nftLikeView)
        
        NSLayoutConstraint.activate([
            nftLikeView.widthAnchor.constraint(equalToConstant: 42),
            nftLikeView.heightAnchor.constraint(equalToConstant: 42),
            nftLikeView.topAnchor.constraint(equalTo: nftImageView.topAnchor),
            nftLikeView.trailingAnchor.constraint(equalTo: nftImageView.trailingAnchor)
        ])
    }
    
    private func setupContainerView() {
        contentView.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalToConstant: 192),
            containerView.heightAnchor.constraint(equalToConstant: 62),
            containerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -39)
        ])
    }
    
    private func setupNFTNameLabel() {
        containerView.addSubview(nftNameLabel)
        
        NSLayoutConstraint.activate([
            nftNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            nftNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
        ])
    }
    
    private func setupRatingView() {
        containerView.addSubview(ratingView)
        
        NSLayoutConstraint.activate([
            ratingView.widthAnchor.constraint(equalToConstant: 68),
            ratingView.heightAnchor.constraint(equalToConstant: 12),
            ratingView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            ratingView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
        ])
    }
    
    private func setupNFTAuthorLabel() {
        containerView.addSubview(nftAuthorLabel)
        
        NSLayoutConstraint.activate([
            nftAuthorLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            nftAuthorLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
        ])
    }
    
    private func setupPriceTitleLabel() {
        containerView.addSubview(priceTitleLabel)
        
        NSLayoutConstraint.activate([
            priceTitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            priceTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 117)
        ])
    }
    
    private func setupPriceLabel() {
        containerView.addSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: priceTitleLabel.bottomAnchor, constant: 2),
            priceLabel.leadingAnchor.constraint(equalTo: priceTitleLabel.leadingAnchor)
        ])
    }
}
