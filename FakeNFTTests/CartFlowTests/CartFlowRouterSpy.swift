//
//  CartFlowRouterSpy.swift
//  FakeNFTTests
//
//  Created by Aleksey Yakushev on 25.10.2023.
//

import UIKit
@testable import FakeNFT

protocol CartFlowRouterSpyProtocol {
    var isDismissCalled: Bool { get }
    var isNetworkErrorCalled: Bool { get }
    
    func reset()
}

final class CartFlowRouterSpy: CartFlowRouterProtocol {
    
    private(set) var isDismissCalled: Bool = false
    private(set) var isNetworkErrorCalled: Bool = false
    
    var cartVC: FakeNFT.CartViewController?
    var checkoutVC: FakeNFT.CheckoutViewController?
    
    func showPaymentError() {
        
    }
    
    func showNetworkError(action: @escaping () -> Void) {
        isNetworkErrorCalled = true
    }
    
    func showSortSheet() {
        
    }
    
    func showAgreementWebView() {
        
    }
    
    func showPaymentScreen() {
        
    }
    
    func showDeleteConfirmationForNFT(_ nft: FakeNFT.ItemNFT?, removalAction: @escaping () -> Void) {
        
    }
    
    func dismiss() {
        isDismissCalled = true
    }
    
    func pop(vc: UIViewController) {
        
    }
    
    func backToCatalog() {
        
    }
}

extension CartFlowRouterSpy: CartFlowRouterSpyProtocol {
    func reset() {
        isDismissCalled = false
        isNetworkErrorCalled = false
    }
}
