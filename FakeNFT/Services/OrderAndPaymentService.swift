//
//  OrderAndPaymentService.swift
//  FakeNFT
//
//  Created by Aleksey Yakushev on 13.10.2023.
//

import Foundation

protocol OrderAndPaymentServiceProtocol {
    var currentOrder: [ItemNFT] {get}
    
    func getOrder() -> [ItemNFT]
    func getCurrency(byID id: String) -> Currency?
    func getAllCurrencies() -> [Currency]
    func payWith(currecyID: String)
    func addItemToOrder(_ newItem: ItemNFT)
    func removeItemFromOrder(_ itemToRemove: ItemNFT)
}

struct cartRequest: NetworkRequest {
    var endpoint: URL?
}

final class OrderAndPaymentService: OrderAndPaymentServiceProtocol {

    static var shared = OrderAndPaymentService()
    private(set) var currentOrder: [ItemNFT] = []
    private var networkClient: NetworkClient
    
    //MARK: - URL paths
    
    private let orderPathString = "orders/1"
    private let getAllCurrenciesPathString = "currencies"
    private let paymentPathString = "/payment/"
    private let getNFTByIDString = "nft/"
    
    private init(networkClient: NetworkClient = DefaultNetworkClient()) {
        self.networkClient = networkClient
    }
    
    private func getNFTbyID(_ id: String) -> ItemNFT? {
        var newItem: ItemNFT? = nil
        let urlString = Config.baseUrl + getNFTByIDString + id
        let request = cartRequest(endpoint: URL(string: urlString))
        networkClient.send(request: request, type: ItemNFT.self, onResponse: { [weak self] result in
            switch result {
            case .success(let item):
                print(item)
                self?.currentOrder.append(item)
            case .failure(let error):
                assertionFailure(error.localizedDescription)
            }
        })

        return newItem
    }
    
    func getOrder() -> [ItemNFT] {
        var itemsList = [ItemNFT]()
        var nftIDList: [String] = []
        let urlString = Config.baseUrl + orderPathString
        let request = cartRequest(endpoint: URL(string: urlString))
        networkClient.send(request: request, type: Order.self, onResponse: { [weak self] result in
            guard let self else {
                return
            }
            switch result {
            case .success(let order):
                order.nfts.forEach({ nft in
                    if let NFTItem = self.getNFTbyID(nft) {
                        print(NFTItem)
                        itemsList.append(NFTItem)
                    }
                })
            case .failure(let error):
                assertionFailure(error.localizedDescription)
            }
        })
    
        return itemsList
    }
    
    private func replaceOrder(with newOrder: [ItemNFT]) {
        
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
    
    func removeItemFromOrder(_ itemToRemove: ItemNFT) {
        
    }
}
