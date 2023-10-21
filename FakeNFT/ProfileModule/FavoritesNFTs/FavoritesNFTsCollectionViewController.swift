//
//  FavoritesNFTsCollectionViewController.swift
//  FakeNFT
//
//  Created by Антон Кашников on 20/10/2023.
//

import UIKit

final class FavoritesNFTsCollectionViewController: UICollectionViewController {
    var navTitle: String?
    
    override func loadView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.isHidden = true
        title = navTitle
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "Backward"),
            style: .plain,
            target: self,
            action: #selector(backButtonDidTap)
        )
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let insets = UIEdgeInsets(top: 20, left: 16, bottom: 0, right: 16)

        collectionView.contentInset = insets
        collectionView.scrollIndicatorInsets = insets
        
        collectionView?.register(
            FavoritesNFTsCollectionViewCell.self,
            forCellWithReuseIdentifier: FavoritesNFTsCollectionViewCell.reuseIdentifier
        )
    }
    
    @objc
    private func backButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: UICollectionViewDataSource

extension FavoritesNFTsCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FavoritesNFTsCollectionViewCell.reuseIdentifier,
            for: indexPath
        )
    
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension FavoritesNFTsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: (collectionView.bounds.width - 39) / 2, height: 80)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        7
    }
}
