//
//  CartFlowRouter.swift
//  FakeNFT
//
//  Created by Aleksey Yakushev on 15.10.2023.
//

import UIKit

protocol CartFlowRouterProtocol {
    var cartVC: CartViewController? { get set }
    var checkoutVC: CheckoutViewController? { get set }
    
    func showPaymentError()
    func showNetworkError(action: @escaping () -> Void)
    func showSortSheet()
    func showAgreementWebView()
    func showPaymentScreen()
    func showDeleteConfirmationForNFT(_ nft: ItemNFT?, removalAction: @escaping () -> Void)
    func dismiss()
    func pop(vc: UIViewController)
    func backToCatalog()
}

final class CartFlowRouter: CartFlowRouterProtocol {
    static var shared = CartFlowRouter()
    weak var cartVC: CartViewController?
    weak var checkoutVC: CheckoutViewController?
    
    private init() { }
    
    // Метод для отображения алерта с ошибкой оплаты
    func showPaymentError() {
        let alert = UIAlertController(title: "Упс! Что-то пошло не так :(",
                                      message: "Попробуйте ещё раз!",
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(okAction)
        
        checkoutVC?.present(alert, animated: true)
    }
    
    // Метод для отображения алерта с ошибкой получения данных
    func showNetworkError(action: @escaping () -> Void) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Упс! Что-то пошло не так :(",
                                          message: "Попробуйте ещё раз!",
                                          preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Отмена", style: .default) { _ in
                self?.cartVC?.dismiss(animated: true)
            }
            
            let retryAction = UIAlertAction(title: "Повторить", style: .cancel) { _ in
                action()
                self?.cartVC?.dismiss(animated: true)
                self?.cartVC?.showProgressView()
            }
            alert.addAction(retryAction)
            alert.addAction(okAction)
            
            self?.cartVC?.present(alert, animated: true)
        }
    }
    
    // Метод вызова алеррта выбора типа сортировки товаров в корзине
    func showSortSheet() {
        let sortSheet = UIAlertController(title: "Сортировка",
                                          message: nil,
                                          preferredStyle: .actionSheet)

        sortSheet.addAction(createAlertAction(type: .price))
        sortSheet.addAction(createAlertAction(type: .rating))
        sortSheet.addAction(createAlertAction(type: .title))

        let close = UIAlertAction(title: "Закрыть", style: .cancel)
        sortSheet.addAction(close)
        
        cartVC?.present(sortSheet, animated: true)
    }
    
    func showAgreementWebView() {
        let webViewmodel = WebViewModel(url: Config.userAgreementUrl)
        let webView = WebViewController()
        webView.model = webViewmodel
        checkoutVC?.show(webView, sender: nil)
    }
    
    // Метод для перехода на экран оплаты
    func showPaymentScreen() {
        let checkout = CheckoutViewController()
        checkout.hidesBottomBarWhenPushed = true
        cartVC?.show(checkout, sender: nil)
    }
    
    // Метод для перехода на экран подтверждения оплаты
    func paymentSuccessfull() {
        let success = PaymentSuccessViewController()
        success.modalPresentationStyle = .fullScreen
        checkoutVC?.present(success, animated: true)
    }
    
    // Метод для отображения полноэкранного алерта при удалении товара
    func showDeleteConfirmationForNFT(_ nft: ItemNFT?, removalAction: @escaping () -> Void) {
        let vc = DeleteConfirmationViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.removalAction = removalAction
        vc.nftImageURL = nft?.images.first
        CartFlowRouter.shared.cartVC?.present(vc, animated: true)
    }
    
    // Метод для скрытия текущего экрана
    func dismiss() {
        cartVC?.dismiss(animated: true)
    }
    
    // Метод для перехода назад по стеку NavigationController
    func pop(vc: UIViewController) {
        vc.navigationController?.popViewController(animated: true)
    }
    
    // Метод для возврата в каталог
    func backToCatalog() {
        if let checkoutVC {
            pop(vc: checkoutVC)
        }
        if let tabBar = cartVC?.tabBarController {
            guard let window = UIApplication.shared.windows.first else { return }
            window.rootViewController = nil
            tabBar.selectedIndex = 1
            UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve, animations: {
                window.rootViewController = tabBar
            }, completion: nil)
        }
    }
    
    //MARK: - Helper methods
    private func createAlertAction(type: CartSortOrder) -> UIAlertAction {
        var title: String?
        switch type {
            case .price:
                title = "По цене"
            case .rating:
                title = "По рейтингу"
            case .title:
                title = "По названию"
        }
        return UIAlertAction(
            title: title,
            style: .default
        ) { [weak self] _ in
            self?.cartVC?.setSorting(to: type)
        }
    }
}
