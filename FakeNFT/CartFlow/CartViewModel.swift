//
//  CartViewModel.swift
//  FakeNFT
//
//  Created by Aleksey Yakushev on 11.10.2023.
//

import Foundation

final class CartViewModel {
    var vc: CartViewController
    private var orderService: OrderAndPaymentServiceProtocol
    private var currency: Currency?
    private(set) var currentOrder: [ItemNFT] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.vc.orderUpdated()
            }
        }
    }
    
    init(orderService: OrderAndPaymentServiceProtocol = OrderAndPaymentService.shared, vc: CartViewController) {
        self.vc = vc
        self.orderService = orderService
        self.orderService.cartVM = self
    }
    
    func setOrder(_ newOrder: [ItemNFT]) {
        currentOrder = newOrder
    }
    
    func getOrder() {
        orderService.getOrder()
    }
    
    func startLoading() {
        vc.showProgressView()
    }
}

extension CartViewModel: CartItemCellDelegate {
    func removeItem(id: String) {
        orderService.removeItemFromOrder(id: id)
    }
}
