//
//  CartFlowRouter.swift
//  FakeNFT
//
//  Created by Aleksey Yakushev on 15.10.2023.
//

import UIKit

final class CartFlowRouter {
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
    
    // Метод для перехода на экран оплаты
    func showPaymentScreen() {
        let checkout = CheckoutViewController()
        checkout.hidesBottomBarWhenPushed = true
        cartVC?.show(checkout, sender: nil)
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
