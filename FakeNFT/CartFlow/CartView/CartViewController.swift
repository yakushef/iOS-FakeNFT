//
//  CartViewController.swift
//  FakeNFT
//
//  Created by Aleksey Yakushev on 11.10.2023.
//

import ProgressHUD
import UIKit

enum CartSortOrder: String {
    case price,
    rating,
    title
}

final class CartViewController: UIViewController {
    
    var viewModel: CartViewModel? = CartViewModel()
    var router: CartFlowRouter? = CartFlowRouter.shared
    private var orderItems: [ItemNFT] = []
    
    //MARK: - UI elements
    private let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    private lazy var cartTable: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(CartItemCell.self)
        table.backgroundColor = .clear
        table.separatorStyle = .none
        
        return table
    }()
    
    private lazy var paymentView: CartTotalView = {
        let view = CartTotalView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var emptyCartLabel: UILabel = {
       let label = UILabel()
        label.textColor = .ypBlack
        label.font = .Bold.small
        label.text = "Корзина пуста"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.$currentOrderSorted.makeBinding { [weak self] _ in
            DispatchQueue.main.async {
                self?.orderUpdated()
            }
        }
        CartFlowRouter.shared.cartVC = self
        
        //временное решение до объединения эпиков с единым TabBarController в коде
        parent?.tabBarItem.image = UIImage(named: "Tab_Cart")
        
        initialSetup()
    }
    
    private func initialSetup() {
        setupUI()
        checkIfEmpty()
        viewModel?.getOrder()
        showProgressView()
    }
    
    //MARK: - UI setup
    private func setupUI() {
        ProgressHUD.animationType = .systemActivityIndicator
        
        [emptyCartLabel,
        paymentView,
         cartTable].forEach{
            view.addSubview($0)
        }
        
        //MARK: - Empty label
        NSLayoutConstraint.activate([
            emptyCartLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyCartLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        //MARK: Sort button
        let sortButton = UIBarButtonItem(image: UIImage(named: "Sort"), style: .plain, target: self, action: #selector(sortButtonTapped))
        sortButton.tintColor = .ypBlack
        navigationItem.rightBarButtonItem = sortButton
        
        //MARK: Payment view
        NSLayoutConstraint.activate([
            paymentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            paymentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            paymentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            paymentView.heightAnchor.constraint(equalToConstant: 76)
        ])
        paymentView.setCheckoutAction { [weak self] in
            self?.payButtonTapped()
        }
    
        //MARK: Cart item table
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
        router?.showSortSheet()
    }
    
    private func payButtonTapped() {
        router?.showPaymentScreen()
    }
    
    //MARK: - Order updated
    func orderUpdated() {
        orderItems = viewModel?.currentOrderSorted ?? []
        paymentView.setQuantity(orderItems.count)
        paymentView.setTotalprice(orderItems.reduce(0) {$0 + $1.price})
        cartTable.reloadData()
        checkIfEmpty()
        hideProgressView()
    }
    
    //MARK: - Helper methods
    private func checkIfEmpty() {
        paymentView.isHidden = orderItems.isEmpty
        cartTable.isHidden = orderItems.isEmpty
        emptyCartLabel.isHidden = !orderItems.isEmpty
    }
    
    private func hideProgressView() {
        ProgressHUD.dismiss()
        view.isUserInteractionEnabled = true
    }
    
    private func showProgressView() {
        ProgressHUD.show()
        view.isUserInteractionEnabled = false
    }
    
    func setSorting(to newSortingStyle: CartSortOrder) {
        viewModel?.setSortingStyle(to: newSortingStyle)
    }
}

//MARK: - TableViewDelegate
extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        140
    }
}

//MARK: - TableViewDataSource
extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        orderItems.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CartItemCell = tableView.dequeueReusableCell()
        cell.setupCellUI()
        cell.delegate = viewModel
        cell.configureCellFor(nft: orderItems[indexPath.row])
        return cell
    }
}
