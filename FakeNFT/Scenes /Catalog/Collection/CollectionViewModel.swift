//
//  CollectionViewModel.swift
//  FakeNFT
//
//  Created by Andy Kruch on 11.10.23.
//

import Foundation

// TO DO Получение данных из сети
final class CollectionViewModel: NSObject {
    
    let collection: Collection
    
    var user = User(name: "Фамилия Имя Отчество",
                    avatar:  "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/179.jpg",
                    description: "Some text",
                    website:  "https://practicum.yandex.ru/qa-engineer/",
                    nfts: ["1", "2"],
                    likes: ["1", "2"],
                    id: "1"
    )
    
    
    var nft1 = ItemNFT(
        createdAt: "2023-04-20T02:22:27Z",
        name: "April",
        images: [
            "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/1.png",
            "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/2.png",
            "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/3.png"
        ],
        rating: 5,
        description: "A 3D model of a mythical creature.",
        price: 4.5,
        author: "6",
        id: "1"
    )
    
    var nft2 = ItemNFT(
        createdAt: "2023-04-20T02:22:27Z",
        name: "April",
        images: [
            "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/1.png",
            "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/2.png",
            "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/3.png"
        ],
        rating: 5,
        description: "A 3D model of a mythical creature.",
        price: 4.5,
        author: "6",
        id: "1"
    )
    
    var nft: [ItemNFT]?
    var profile = Profile(name: "Студентус Практикумус",
                          avatar: "https://code.s3.yandex.net/landings-v2-ios-developer/space.PNG",
                          description: "Прошел 5-й спринт, и этот пройду",
                          website: "https://practicum.yandex.ru/ios-developer/",
                          nfts: [
                            "68",
                            "69",
                            "71",
                            "72",
                            "73",
                            "74",
                            "75",
                            "76",
                            "77",
                            "78",
                            "79",
                            "80",
                            "81"
                          ],
                          likes: [
                            "5",
                            "13",
                            "19",
                            "26",
                            "27",
                            "33",
                            "35",
                            "39",
                            "41",
                            "47",
                            "56",
                            "66"
                          ],
                          id: "1"
    )
    
    var order = Order (nfts: [
        "93",
        "94",
        "95"
    ],
                       id: "1")
    
    var reloadData: (() -> Void)?
    
    init(collection: Collection) {
        self.collection = Collection(createdAt: "2023-04-20T02:22:27Z",
                                     name: "Beige",
                                     cover: "https://code.s3.yandex.net/Mobile/iOS/NFT/Обложки_коллекций/Beige.png",
                                     nfts: [
                                        "1",
                                        "2",
                                     ],
                                     description: "A series of one-of-a-kind NFTs featuring historic moments in sports history.",
                                     author: "6",
                                     id: "1"
        )
        super .init()
        fetchNFTData()
        fetchProfileData()
        fetchOrderData()
    }
    
    
    func fetchNFTData() {
        // TO DO
    }
    
    private func fetchOrderData() {
        // TO DO
    }
    
    private func fetchProfileData() {
        // TO DO
    }
    
    func updateLikeForNFT() {
        // TO DO
    }
    
    private func updateProfileData() {
        // TO DO
    }
    
    func updateCartForNFT() {
        // TO DO
    }
    
    private func updateOrderData() {
        // TO DO
    }
    
    func nfts(by id: String) -> ItemNFT? {
        nft?.first { $0.id == id }
    }
    
    func isNFTLiked(with nftId: String) -> Bool {
        return profile.likes.contains(nftId)
    }
    
    func isNFTInOrder(with nftId: String) -> Bool {
        return order.nfts.contains(nftId)
    }
}

