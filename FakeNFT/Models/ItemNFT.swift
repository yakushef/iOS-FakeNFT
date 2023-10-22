//
//  ItemNFT.swift
//  FakeNFT
//
//  Created by Andy Kruch on 10.10.23.
//

import Foundation

struct ItemNFT: Codable, Equatable {
    let createdAt: String
    let name: String
    let images: [String]
    let rating: Int
    let description: String
    let price: Float
    let author: String
    let id: String
}
