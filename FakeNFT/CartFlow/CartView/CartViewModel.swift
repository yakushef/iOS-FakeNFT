//
//  CartViewModel.swift
//  FakeNFT
//
//  Created by Aleksey Yakushev on 11.10.2023.
//

import Foundation

final class CartViewModel {
    private var orderService: OrderAndPaymentServiceProtocol
    @Observable private(set) var currentOrder: [ItemNFT] = []
    
    init(orderService: OrderAndPaymentServiceProtocol = OrderAndPaymentService.shared) {
        self.orderService = orderService
        self.orderService.cartVM = self
    }
    
    func setOrder(_ newOrder: [ItemNFT]) {
        currentOrder = newOrder
    }
    
    func getOrder() {
        orderService.getOrder()
    }
    
    func orderUpdated() {
        CartFlowRouter.shared.dismiss()
        getOrder()
    }
}

extension CartViewModel: CartItemCellDelegate {
    func removeItem(id: String) {
        orderService.removeItemFromOrder(id: id)
    }
}
