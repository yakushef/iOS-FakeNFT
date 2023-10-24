//
//  CheckoutViewModel.swift
//  FakeNFT
//
//  Created by Aleksey Yakushev on 17.10.2023.
//

import Foundation

final class CheckoutViewModel {
    private var router = CartFlowRouter.shared
    private var orderService: CheckoutServiceProtocol
    private var currencyID: String?
    @Observable private(set) var currencyList: [Currency] = []
    
    init(orderService: CheckoutServiceProtocol = OrderAndPaymentService.shared, currency: Currency? = nil) {
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
    
    func makePayment() {
        guard let id = currencyID else {return}
        orderService.payWith(currecyID: id)
        currencyID = nil
    }
    
    func paymentSuccessfull() {
        //TODO: - Handle successfull payment
        router.paymentSuccessfull()
    }
    
    func paymentFailed() {
        //TODO: - Handle payment failure
        router.showPaymentError()
    }
}
