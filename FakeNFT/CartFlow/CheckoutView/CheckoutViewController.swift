//
//  CheckoutViewController.swift
//  FakeNFT
//
//  Created by Aleksey Yakushev on 15.10.2023.
//

import UIKit
import ProgressHUD

final class CheckoutViewController: UIViewController {
    private var viewModel: CheckoutViewModel?
    private lazy var paymentView: UIView = {
        MakePaymentView()
    }()
    private lazy var currencyCollection: UICollectionView = {
       let currencyCollection = UICollectionView(frame: CGRect(),
                                                 collectionViewLayout: UICollectionViewLayout())
       return currencyCollection
    }()
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypWhite
        navigationItem.title = "Выберете способ оплаты"
        viewModel = CheckoutViewModel()
        viewModel?.$currencyList.makeBinding(action: { [weak self] _ in
            DispatchQueue.main.async {
                self?.currencyListUpdated()
            }
        })
        
        setupUI()
        viewModel?.getCurrencyList()
        ProgressHUD.show()
    }
    
    func setupUI() {
        setupCollection()
        
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
    
    private func currencyListUpdated() {
            self.currencyCollection.reloadData()
            ProgressHUD.dismiss()
    }
}

extension CheckoutViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let currency = viewModel?.currencyList[indexPath.row] {
            viewModel?.setCurrencyTo(id: currency.id)
        }
    }
    
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
        viewModel?.currencyList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CurrencyCell = collectionView.dequeueReusableCell(indexPath: indexPath)
        let currency = viewModel?.currencyList[indexPath.row]
        cell.configureCell(for: currency)
        return cell
    }
}
