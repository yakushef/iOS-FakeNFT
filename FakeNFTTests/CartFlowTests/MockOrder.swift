//
//  MockOrder.swift
//  FakeNFTTests
//
//  Created by Aleksey Yakushev on 25.10.2023.
//

import Foundation
@testable import FakeNFT

struct MockOrder {
    static let testItem1 = ItemNFT(createdAt: "",
                            name: "A",
                            images: [],
                            rating: 1,
                            description: "",
                            price: 100,
                            author: "",
                            id: "1")
    static let testItem2 = ItemNFT(createdAt: "",
                            name: "B",
                            images: [],
                            rating: 3,
                            description: "",
                            price: 50,
                            author: "",
                            id: "2")
    static let testItem3 = ItemNFT(createdAt: "",
                            name: "C",
                            images: [],
                            rating: 5,
                            description: "",
                            price: 80,
                            author: "",
                            id: "3")
    static let testItem4 = ItemNFT(createdAt: "",
                            name: "D",
                            images: [],
                            rating: 4,
                            description: "",
                            price: 60,
                            author: "",
                            id: "4")
    static let testItem5 = ItemNFT(createdAt: "",
                            name: "E",
                            images: [],
                            rating: 2,
                            description: "",
                            price: 110,
                            author: "",
                            id: "5")

    static let testItems: [ItemNFT] = { [testItem1,
                                         testItem2,
                                         testItem3,
                                         testItem4,
                                         testItem5] }()
}
