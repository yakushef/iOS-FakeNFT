//
//  OrderAndPaymentService.swift
//  FakeNFT
//
//  Created by Aleksey Yakushev on 13.10.2023.
//

import Foundation

protocol OrderAndPaymentServiceProtocol {
    var cartVM: CartViewModel? {get set}
    var currentOrderItems: [ItemNFT] {get}
    
    func getOrder()
    func getCurrency(byID id: String) -> Currency?
    func getAllCurrencies() -> [Currency]
    func payWith(currecyID: String)
    func addItemToOrder(_ newItem: ItemNFT)
    func removeItemFromOrder(id: String)
}

struct cartRequest: NetworkRequest {
    var endpoint: URL?
}

struct cartChangeRequest: NetworkRequest {
    var endpoint: URL?
    var httpMethod: HttpMethod = .put
    var dto: [String]
}

final class OrderAndPaymentService: OrderAndPaymentServiceProtocol {
    var cartVM: CartViewModel?

    static var shared = OrderAndPaymentService()
    private(set) var currentOrderItems: [ItemNFT] = [] {
        didSet {
            if currentOrder?.nfts.count == currentOrderItems.count {
                cartVM?.setOrder(currentOrderItems)
            }
        }
    }
    private var networkClient: NetworkClient
    private var currentOrder: Order? = nil {
        didSet {
            getOrderItems()
        }
    }
    
    //MARK: - URL paths
    
    private let orderPathString = "orders/1"
    private let getAllCurrenciesPathString = "currencies"
    private let paymentPathString = "/payment/"
    private let getNFTByIDString = "nft/"
    
    private init(networkClient: NetworkClient = DefaultNetworkClient()) {
        self.networkClient = networkClient
    }
    
    private func getNFTbyID(_ id: String) {
        let urlString = Config.baseUrl + getNFTByIDString + id
        let request = cartRequest(endpoint: URL(string: urlString))
        networkClient.send(request: request, type: ItemNFT.self, onResponse: { [weak self] result in
            switch result {
            case .success(let item):
                self?.currentOrderItems.append(item)
            case .failure(let error):
                assertionFailure(error.localizedDescription)
            }
        })
    }
    
    func getOrder() {
        let urlString = Config.baseUrl + orderPathString
        let request = cartRequest(endpoint: URL(string: urlString))
        networkClient.send(request: request, type: Order.self, onResponse: { [weak self] result in
            guard let self else {
                return
            }
            switch result {
            case .success(let order):
                self.currentOrder = order
            case .failure(let error):
                self.currentOrder = nil
                self.currentOrderItems = []
                assertionFailure(error.localizedDescription)
            }
        })
    }
    
    private func getOrderItems() {
        currentOrderItems = []
        
        if let nfts = currentOrder?.nfts {
            for nft in nfts {
                getNFTbyID(nft)
            }
        }
    }
    
    private func replaceOrder(with newOrder: Order) {
        let url = Config.baseUrl + orderPathString
        let request = cartChangeRequest(endpoint: URL(string: url)!,
                                        dto: newOrder.nfts)
        networkClient.send(request: request, onResponse: { [weak self] result in
            switch result {
            case .success(let data):
                self?.getOrder()
            case .failure(let error):
                assertionFailure(error.localizedDescription)
            }
        })
    }
    
    //MARK: - Cart protocol methods
    
    func payWith(currecyID: String) {
        
    }
    
    func getAllCurrencies() -> [Currency] {
        return []
    }
    
    func getCurrency(byID id: String) -> Currency? {
        return nil
    }
    
    func addItemToOrder(_ newItem: ItemNFT) {
        
    }
    
    func removeItemFromOrder(id: String) {
        let newNFTs = currentOrder?.nfts.filter { $0 != id } ?? []
        let newOrder = Order(nfts: newNFTs,
                             id: currentOrder?.id ?? "1")
        replaceOrder(with: newOrder)
    }
}
