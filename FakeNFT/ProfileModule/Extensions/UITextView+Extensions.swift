//
//  UITextView+Extensions.swift
//  FakeNFT
//
//  Created by Антон Кашников on 14/10/2023.
//

import UIKit

extension UITextView {
    convenience init(text: String) {
        self.init()
        self.text = text
        isScrollEnabled = false
        textContainerInset = UIEdgeInsets(top: 11, left: 16, bottom: 11, right: 16)
        font = UIFont.systemFont(ofSize: 17)
        backgroundColor = .ypLightGrey
        layer.cornerRadius = 12
        translatesAutoresizingMaskIntoConstraints = false
    }
}
