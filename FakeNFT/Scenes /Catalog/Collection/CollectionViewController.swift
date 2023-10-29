//
//  CollectionViewController.swift
//  FakeNFT
//
//  Created by Andy Kruch on 11.10.23.
//

import UIKit
import Kingfisher

final class CollectionViewController: UIViewController {
    
    private let viewModel: CollectionViewModel
 
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        collectionView.register(DescriptionCollectionViewCell.self, forCellWithReuseIdentifier: DescriptionCollectionViewCell.identifier)
        collectionView.register(NFTCollectionViewCell.self, forCellWithReuseIdentifier: NFTCollectionViewCell.identifier)
        return collectionView
    }()
    
    init(viewModel: CollectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.reloadData = self.collectionView.reloadData
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        addSubviews()
        setupConstraints()
        setupNavBar()
        setupCollectionView()
        
        viewModel.onError = { [weak self] error, retryAction in
            let alert = UIAlertController(title: "Не удалось получить данные", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
            alert.addAction(UIAlertAction(title: "Повторить", style: .default, handler: { _ in
                retryAction()
            }))
            self?.present(alert, animated: true, completion: nil)
        }
    }
        
    private func addSubviews() {
        [collectionView].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func likeButtonTapped(nftIndex: String) {
        viewModel.updateLikeForNFT(with: nftIndex)
    }
    
    private func cartButtonTapped(nftIndex: String) {
        viewModel.updateCartForNFT(with: nftIndex)
    }
    
    private func setupNavBar() {
        if let navBar = navigationController?.navigationBar {
            let leftImageButton = UIImage(systemName: "chevron.backward")?
                .withTintColor(.black)
                .withRenderingMode(.alwaysOriginal)
            let leftBarButton = UIBarButtonItem(
                image: leftImageButton,
                style: .plain,
                target: self,
                action: #selector(self.leftNavigationBarButtonTapped)
            )
            navigationItem.leftBarButtonItem = leftBarButton
            navBar.tintColor = .black
            navBar.isTranslucent = true
        }
    }
    
    @objc private func leftNavigationBarButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func showWebViewAboutAuthor() {
        let webViewVC = WebView()
        guard let url = URL(string: self.viewModel.user?.website ?? "") else { return }
        webViewVC.url = url
        self.navigationController?.pushViewController(webViewVC, animated: true)
        tabBarController?.tabBar.isHidden = true
        tabBarController?.tabBar.isTranslucent = true
    }
    
    private func showCollectionItemView() {
        let collectionItemVC = ProductDetailsTableViewController()
        self.navigationController?.pushViewController(collectionItemVC, animated: true)
    }
}

//MARK: - UICollectionViewDataSource
extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        guard let section = CollectionNFTSection(rawValue: section) else { return .zero }
        switch section {
        case .image:
            return 1
        case .description:
            return 1
        case .nft:
            return self.viewModel.collection.nfts.count
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let section = CollectionNFTSection(rawValue: indexPath.section) else { return UICollectionViewCell() }
        guard let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        guard let descriptionCell = collectionView.dequeueReusableCell(withReuseIdentifier: DescriptionCollectionViewCell.identifier, for: indexPath) as? DescriptionCollectionViewCell else { return UICollectionViewCell() }
        guard let nftCell = collectionView.dequeueReusableCell(withReuseIdentifier: NFTCollectionViewCell.identifier, for: indexPath) as? NFTCollectionViewCell else { return UICollectionViewCell() }
        
        let predictViewModel = self.viewModel
        switch section {
            
        case .image:
           
            if let imageURLString = predictViewModel.collection.cover,
               let imageURl = URL(string: imageURLString.encodeURL) {
                imageCell.imageView.kf.setImage(with: imageURl)
            }
            imageCell.configure(collectionImageAction: showCollectionItemView)
            return imageCell
            
        case .description:
            
            descriptionCell.configure(
                collectionName: predictViewModel.collection.name,
                subTitle: "Автор коллекции:",
                authorName: predictViewModel.user?.name ?? "",
                description: predictViewModel.collection.description,
                authorNameButtonAction: showWebViewAboutAuthor)
            return descriptionCell
            
        case .nft:
            var likeButton: String
            var cartButton: String
            
            
            let nftIndex = self.viewModel.collection.nfts[indexPath.row]
            
            if let imageURLString = predictViewModel.nfts(by: nftIndex)?.images.first,
               let imageURL = URL(string: imageURLString.encodeURL),
               let price = predictViewModel.nfts(by: nftIndex)?.price.ethCurrency,
               let nftName = predictViewModel.nfts(by: nftIndex)?.name {
                let isNFTLiked = predictViewModel.isNFTLiked(with: nftIndex)
                let isNFTInOrder = predictViewModel.isNFTInOrder(with: nftIndex)
                
                likeButton = isNFTLiked ? "like" : "dislike"
                cartButton = isNFTInOrder ? "inCart" : "cart"
                
                nftCell.configure(nftImage: imageURL, 
                                  likeOrDislike: likeButton,
                                  nftName: nftName,
                                  price: price,
                                  cartImage: cartButton,
                                  collectionImageAction: showCollectionItemView
                )
                print(nftIndex, nftName, price)
                
            }
            
            nftCell.collectLikesAndCart(likeButtonInteraction: { [weak self] in self?.likeButtonTapped(nftIndex: nftIndex)},
                                        cartButtonInteraction: { [weak self] in self?.cartButtonTapped(nftIndex: nftIndex)})
                        
            nftCell.collectRating(rating: predictViewModel.rateCollection(by: nftIndex)?.rating ?? 0)
            
            return nftCell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        CollectionNFTSection.allCases.count
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        guard let section = CollectionNFTSection(rawValue: indexPath.section) else { return .zero }
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 50) / 3
        let cgSize = CGSize(width: width, height: 200)
        
        switch section {
        case .image:
            return CGSize(width: self.collectionView.bounds.width, height: 310)
        case .description:
            return CGSize(width: self.collectionView.bounds.width, height: 160)
        case .nft:
            return cgSize
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return .zero
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return .zero
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        guard let section = CollectionNFTSection(rawValue: section) else { return .zero }
        switch section {
        case .image:
            return .zero
        case .description:
            return .zero
        case .nft:
            return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
    }
}
