//
//  MakePaymentView.swift
//  FakeNFT
//
//  Created by Aleksey Yakushev on 17.10.2023.
//

import UIKit

class MakePaymentView: UIView {
    private let insets = UIEdgeInsets(top: 16,
                                      left: 16,
                                      bottom: 16,
                                      right: 16)
    private lazy var payButton: UIButton = {
        let payButton = UIButton(type: .system)
        payButton.setTitle("Оплатить",
                           for: .normal)
        payButton.titleLabel?.font = .Bold.small
        payButton.backgroundColor = .ypBlack
        payButton.tintColor = .ypWhite
        payButton.clipsToBounds = true
        payButton.layer.cornerRadius = 16
        payButton.addTarget(self,
                            action: #selector(payButtonTapped),
                            for: .touchUpInside)
        return payButton
    }()
    
    private lazy var userAgreementButton: UIButton = {
        let agreementButton = UIButton(type: .system)
        agreementButton.tintColor = .blueUniversal
        agreementButton.setTitle("Пользовательского соглашения",
                                 for: .normal)
        agreementButton.titleLabel?.font = .Regular.small
        agreementButton.backgroundColor = .clear
        agreementButton.contentHorizontalAlignment = .left
        return agreementButton
    }()
    
    private lazy var disclaimerLabel: UILabel = {
        let disclaimerLabel = UILabel()
        disclaimerLabel.text = "Совершая покупку, вы соглашаетесь с условиями"
        disclaimerLabel.textColor = .ypBlack
        disclaimerLabel.font = .Regular.small
        disclaimerLabel.backgroundColor = .clear
        disclaimerLabel.textAlignment = .left
        return disclaimerLabel
    }()
    
    private var paymentAction: () -> Void = { }

    //MARK: - Lifecycle
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPaymentAction(action: @escaping () -> Void) {
        paymentAction = action
    }
    
    //MARK: - UI setup
    
    func setupUI() {
        backgroundColor = .ypLightGrey
        clipsToBounds = true
        layer.cornerRadius = 12
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        addSubview(payButton)
        payButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            payButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left),
            payButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -insets.right),
            payButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -insets.bottom),
            payButton.heightAnchor.constraint(equalToConstant: 60),
        ])
        
        addSubview(userAgreementButton)
        userAgreementButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userAgreementButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left),
            userAgreementButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -insets.right),
            userAgreementButton.bottomAnchor.constraint(equalTo: payButton.topAnchor, constant: -insets.top)
        ])
        
        addSubview(disclaimerLabel)
        disclaimerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            disclaimerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left),
            disclaimerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -insets.right),
            disclaimerLabel.bottomAnchor.constraint(equalTo: userAgreementButton.topAnchor),
            disclaimerLabel.topAnchor.constraint(equalTo: topAnchor, constant: insets.top)
        ])
    }
    
    @objc private func payButtonTapped() {
        paymentAction()
    }
}
