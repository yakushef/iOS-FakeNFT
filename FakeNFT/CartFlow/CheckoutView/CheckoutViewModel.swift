//
//  CheckoutViewModel.swift
//  FakeNFT
//
//  Created by Aleksey Yakushev on 17.10.2023.
//

import Foundation

final class CheckoutViewModel {
    private var orderService: OrderAndPaymentServiceProtocol
    private var currencyID: String?
    @Observable private(set) var currencyList: [Currency] = []
    
    
    init(orderService: OrderAndPaymentServiceProtocol = OrderAndPaymentService.shared, currency: Currency? = nil) {
        self.orderService = orderService
        self.orderService.checkoutVM = self
        self.currencyID = currency?.id
    }
    
    func getCurrencyList() {
        orderService.getAllCurrencies()
    }
    
    func setCurrencyList(to newCurrencyList: [Currency]) {
        currencyList = newCurrencyList
    }
    
    func setCurrencyTo(id: String) {
        currencyID = id
    }
}
