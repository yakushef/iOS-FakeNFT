//
//  PaymentView.swift
//  FakeNFT
//
//  Created by Aleksey Yakushev on 11.10.2023.
//

import UIKit

final class PaymentView: UIView {
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = .ypLightGrey
    }
}
