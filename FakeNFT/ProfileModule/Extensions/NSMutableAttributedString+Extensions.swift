//
//  NSMutableAttributedString+Extensions.swift
//  FakeNFT
//
//  Created by Антон Кашников on 12/10/2023.
//

import Foundation

extension NSMutableAttributedString {
    public func setAsLink(textToFind: String, linkURL: String) -> Bool {
        let foundRange = mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            addAttribute(.link, value: linkURL, range: foundRange)
            return true
        }
        return false
    }
}
