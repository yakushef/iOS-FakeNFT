//
//  CollectionViewModel.swift
//  FakeNFT
//
//  Created by Andy Kruch on 11.10.23.
//

import Foundation

final class CollectionViewModel: NSObject {
    let collection: Collection
    
    var user: UserCollection?
    var nft: [ItemNFT]?
    var profile: Profile?
    var order: OrderCollection?
    
    var reloadData: (() -> Void)?
    
    init(collection: Collection) {
        self.collection = collection
        super .init()
        fetchUserData()
        fetchNFTData()
        fetchProfileData()
        fetchOrderData()
    }
    
    func fetchUserData() {
        
        let data = User(name: "Elijah Anderson", avatar:  "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/179.jpg", description: "NFT collector and enthusiast 🚀", website: "https://practicum.yandex.ru/qa-engineer/", nfts: [
            "1",
            "4",
            "6",
            "8"
        ], rating: "77", id: "1")
        self.user = UserCollection(with: data)
    }
    
    func fetchNFTData() {
        self.nft = [ItemNFT(createdAt: "2023-04-20T02:22:27Z", name: "April", images: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/1.png", "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/2.png", "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/3.png"], rating: 5, description: "A 3D model of a mythical creature.", price: 4.5, author: "6", id: "1")]
    }
    
    private func fetchOrderData() {
        let data = Order(nfts: ["93", "95", "23", "75", "92", "50", "59", "56", "1", "74", "22"], id: "1")
        
        self.order = OrderCollection(with: data)
    }
    
    private func fetchProfileData() {
        let data = Profile(name: "Студентус практикус", avatar: "https://3.bp.blogspot.com/-qmHbrjpisRg/V6xgteIDhCI/AAAAAAAAABI/WdlSlkwqAgQJd9Z2BZJ6tdUuZUAnEaS_wCLcB/s1600/Bradley-Cooper.jpg", description: "Прошел 5-й спринт, и этот пройду Прошел 5-й спринт, и этот пройду Прошел 5-й спринт, и этот пройду ", website: "https://practicum.yandex.ru/ios-developer", nfts: ["68", "69", "71"], likes: ["35", "39", "41", "47", "56", "66", "68", "69", "21", "75", "92", "50", "59", "1", "74", "2", "10", "11", "22", "23"], id: "1" )
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
        return ((profile?.likes.contains(nftId)) != nil)
    }
    
    func isNFTInOrder(with nftId: String) -> Bool {
        return ((order?.nfts.contains(nftId)) != nil)
    }
}

