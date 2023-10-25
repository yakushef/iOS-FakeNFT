//
//  CheckoutViewModelTests.swift
//  FakeNFTTests
//
//  Created by Aleksey Yakushev on 25.10.2023.
//

@testable import FakeNFT
import XCTest

final class CheckoutViewModelTests: XCTestCase {
    var router: CartFlowRouterSpyProtocol & CartFlowRouterProtocol = CartFlowRouterSpy()
    
    override func setUpWithError() throws {
        
    }
    
    //MARK: - Currency
    
    func testGetCurrencyList() {
        
    }
    
    func testSetCurrencyList() {
        
    }
    
    func testSetCurrency() {
        
    }
    
    //MARK: - Payment
    
    func testMakePayment() {
        
    }
    
    func testSuccessfulPayment() {
        
    }
    
    func testFailedPayment() {
        
    }
    
    func testNetworkError() {
        
    }
}
