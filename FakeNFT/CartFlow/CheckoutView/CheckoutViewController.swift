//
//  CheckoutViewController.swift
//  FakeNFT
//
//  Created by Aleksey Yakushev on 15.10.2023.
//

import UIKit

final class CheckoutViewController: UIViewController {
    private lazy var currencyCollection: UICollectionView = {
       let currencyCollection = UICollectionView(frame: CGRect(),
                                                 collectionViewLayout: UICollectionViewLayout())
       return currencyCollection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypWhite
        navigationItem.title = "Выберете способ оплаты"
        
        setupUI()
    }
    
    func setupUI() {
        setupCollection()
        
        let paymentView = MakePaymentView()
        view.addSubview(paymentView)
        paymentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            paymentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            paymentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            paymentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    private func setupCollection() {
        let frame = view.safeAreaLayoutGuide.layoutFrame
        let layout = UICollectionViewFlowLayout()
        currencyCollection = UICollectionView(frame: frame, collectionViewLayout: layout)
        
        currencyCollection.dataSource = self
        currencyCollection.delegate = self
        currencyCollection.contentInset = UIEdgeInsets(top: 20,
                                                       left: 16,
                                                       bottom: 20,
                                                       right: 16)
        currencyCollection.register(CurrencyCell.self)
        view.addSubview(currencyCollection)
    }
}

extension CheckoutViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        7
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        7
    }
}

extension CheckoutViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width - 7) / 2  - collectionView.contentInset.left
        return CGSize(width: cellWidth, height: 46)
    }
}

extension CheckoutViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CurrencyCell = collectionView.dequeueReusableCell(indexPath: indexPath)
        cell.configureCell(for: nil)
        return cell
    }
}
