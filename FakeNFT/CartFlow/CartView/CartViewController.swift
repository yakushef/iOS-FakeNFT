//
//  CartViewController.swift
//  FakeNFT
//
//  Created by Aleksey Yakushev on 11.10.2023.
//

import UIKit
import ProgressHUD

enum CartSortOrder {
    case price,
    rating,
    title
}

final class CartViewController: UIViewController {
    
    var viewModel: CartViewModel? = CartViewModel()
    var router = CartFlowRouter.shared
    private var orderItems: [ItemNFT] = []
    
    private var sortingStyle: CartSortOrder = .title {
        didSet {
            applySorting()
        }
    }
    
    init(viewModel: CartViewModel? = CartViewModel(),
         router: CartFlowRouter = CartFlowRouter.shared,
         orderItems: [ItemNFT] = [],
         sortingStyle: CartSortOrder = .title) {
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
        self.router = router
        self.orderItems = orderItems
        self.sortingStyle = sortingStyle
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
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
    
    private lazy var paymentView: CheckoutView = {
        let view = CheckoutView()
        return view
    }()

    private lazy var emptyCartLabel: UILabel = {
       let label = UILabel()
        label.textColor = .ypBlack
        label.font = .bold17
        label.text = "Корзина пуста"
        return label
    }()

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.$currentOrder.makeBinding { [weak self] _ in
            DispatchQueue.main.async {
                self?.orderUpdated()
            }
        }
        CartFlowRouter.shared.cartVC = self
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkIfEmpty()
        viewModel?.getOrder()
        showProgressView()
    }
    
    //MARK: - UI setup
    private func setupUI() {
        ProgressHUD.animationType = .systemActivityIndicator
        
        //MARK: - Empty label
        view.addSubview(emptyCartLabel)
        emptyCartLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyCartLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyCartLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
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
        paymentView.payButton.addTarget(self, action: #selector(payButtonTapped), for: .touchUpInside)
    
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
        router.showSortSheet()
    }
    
    @objc private func payButtonTapped() {
        router.showPaymentScreen()
    }
    
    func orderUpdated() {
        orderItems = viewModel?.currentOrder ?? []
        applySorting()
        paymentView.setQuantity(orderItems.count)
        paymentView.setTotalprice(orderItems.reduce(0) {$0 + $1.price})
        checkIfEmpty()
        hideProgressView()
    }
    
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
        sortingStyle = newSortingStyle
    }
    
    private func applySorting() {
        switch sortingStyle {
        case .price:
            orderItems.sort { item1, item2 in
                item1.price > item2.price
            }
        case .rating:
            orderItems.sort { item1, item2 in
                item1.rating > item2.rating
            }
        case .title:
            orderItems.sort { item1, item2 in
                item1.name > item2.name
            }
        }
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
        cell.delegate = viewModel
        cell.configureCellFor(nft: orderItems[indexPath.row])
        return cell
    }
}
