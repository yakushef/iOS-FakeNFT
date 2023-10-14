//
//  CatalogViewModel.swift
//  FakeNFT
//
//  Created by Andy Kruch on 10.10.23.
//

import Foundation

final class CatalogViewModel {
    
    private (set) var collections: [Collection] = []
    
    var reloadData: (() -> Void)?
    
}
