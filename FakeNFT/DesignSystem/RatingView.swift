//
//  RatingView.swift
//  FakeNFT
//
//  Created by Aleksey Yakushev on 11.10.2023.
//

import UIKit

final class RatingView: UIView {
    
    private var rating: UInt = 0 {
        didSet {
            stars.forEach { star in
                changeStarStatus(star: star, isActive: !(rating < star.tag))
            }
        }
    }
    
    private var star1: UIImageView = {
        let star = UIImageView()
        star.tag = 1
        return star
    }()
    private var star2: UIImageView = {
        let star = UIImageView()
        star.tag = 2
        return star
    }()
    private var star3: UIImageView = {
        let star = UIImageView()
        star.tag = 3
        return star
    }()
    private var star4: UIImageView = {
        let star = UIImageView()
        star.tag = 4
        return star
    }()
    private var star5: UIImageView = {
        let star = UIImageView()
        star.tag = 5
        return star
    }()
    
    private lazy var stars = [
        star1,
        star2,
        star3,
        star4,
        star5
    ]
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Set rating (0 to 5 stars)
    func setRating(to newRating: UInt) {
        rating = newRating
    }
    
    private func changeStarStatus(star: UIImageView, isActive: Bool) {
        star.image = UIImage(named: isActive ? "Star_Active" : "Star_Inactive")
    }
    
    private func setupUI() {
        let starStack = UIStackView()
        starStack.axis = .horizontal
        starStack.distribution = .equalSpacing
        stars.forEach { star in
            star.heightAnchor.constraint(equalToConstant: 12).isActive = true
            star.heightAnchor.constraint(equalToConstant: 12).isActive = true
            starStack.addArrangedSubview(star)
            star.translatesAutoresizingMaskIntoConstraints = false
        }
        addSubview(starStack)
        starStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            starStack.heightAnchor.constraint(equalToConstant: 12),
            starStack.widthAnchor.constraint(equalToConstant: 68),
            starStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            starStack.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

}
