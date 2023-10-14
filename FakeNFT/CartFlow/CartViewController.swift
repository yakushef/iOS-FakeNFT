//
//  CartViewController.swift
//  FakeNFT
//
//  Created by Aleksey Yakushev on 11.10.2023.
//

import UIKit

final class CartViewController: UIViewController {
    
    var viewModel: CartViewModel?
    private var orderItems: [ItemNFT] = []
    
    private lazy var cartTable: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(CartItemCell.self)
        table.backgroundColor = .clear
        table.separatorStyle = .none
        
        return table
    }()
    
    private lazy var paymentView: CheckoutView = {
        let view = CheckoutView()
        return view
    }()

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CartViewModel(vc: self)
        
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
        view.addSubview(cartTable)
        cartTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cartTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cartTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cartTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cartTable.bottomAnchor.constraint(equalTo: paymentView.topAnchor)
        ])
    }
    
    //MARK: - Navigation
    @objc private func sortButtonTapped() {
        
    }
    
    func orderUpdated() {
        orderItems = viewModel?.currentOrder ?? []
            print(viewModel?.currentOrder)
            cartTable.reloadData()
        }
}

//MARK: - TableViewDelegate
extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        140
    }
}

//MARK: - TableViewDataSource
extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        orderItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CartItemCell = tableView.dequeueReusableCell()
        cell.setupCellUI()
        cell.configureCellFor(nft: orderItems[indexPath.row])
        return cell
    }
}
