//
//  PaymentSuccessViewController.swift
//  FakeNFT
//
//  Created by Aleksey Yakushev on 22.10.2023.
//

import UIKit

class PaymentSuccessViewController: UIViewController {
    var router = CartFlowRouter.shared
    private lazy var successImageView: UIImageView = {
        let image = UIImage(named: "Payment_Success")
        let imageView = UIImageView(image: image)
        imageView.heightAnchor.constraint(equalToConstant: 278).isActive = true
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
        return imageView
    }()
    
    private lazy var returnButton: UIButton = {
        let button = GenericButton()
        button.setTitle("Вернуться в каталог", for: .normal)
        return button
    }()
    
    private var returnAction: () -> Void = { }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .ypWhite
        setNeedsStatusBarAppearanceUpdate()
        
        view.addSubview(successImageView)
        successImageView.translatesAutoresizingMaskIntoConstraints = false
        successImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        successImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc
    private func returnButtonTapped() {
        router.backToCatalog()
    }
}
