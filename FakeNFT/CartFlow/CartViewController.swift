//
//  CartViewController.swift
//  FakeNFT
//
//  Created by Aleksey Yakushev on 11.10.2023.
//

import UIKit

final class CartViewController: UIViewController {
    
    private lazy var cartTable: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(CartItemCell.self)
        table.backgroundColor = .ypBlack
        
        return table
    }()
    
    private lazy var paymentView: PaymentView = {
        let view = PaymentView()
        return view
    }()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    //MARK: - UI setup
    private func setupUI() {
        
        //MARK: Sort button
        let sortButton = UIBarButtonItem(image: UIImage(named: "Sort"), style: .plain, target: self, action: #selector(sortButtonTapped))
        sortButton.tintColor = .ypBlack
        navigationItem.rightBarButtonItem = sortButton
        
        //MARK: Payment view
        view.addSubview(paymentView)
        paymentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            paymentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            paymentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            paymentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            paymentView.heightAnchor.constraint(equalToConstant: 76)
        ])
    
        //MARK: Cart item table
        
    }
    
    //MARK: - Navigation
    @objc private func sortButtonTapped() {
        
    }
}

//MARK: - TableViewDelegate
extension CartViewController: UITableViewDelegate {
    
}

//MARK: - TableViewDataSource
extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
