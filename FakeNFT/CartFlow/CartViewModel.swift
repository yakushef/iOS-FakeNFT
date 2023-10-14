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
    private(set) var currentOrder: [ItemNFT] = []
    
    init(orderService: OrderAndPaymentServiceProtocol = OrderAndPaymentService.shared, vc: CartViewController) {
        self.vc = vc
        self.orderService = orderService
        orderService.getOrder()
        
        DispatchQueue.main.asyncAfter(deadline: .now()+5, execute: {
            self.currentOrder = orderService.currentOrder
            vc.orderUpdated()
        })
        
        
    }
}
