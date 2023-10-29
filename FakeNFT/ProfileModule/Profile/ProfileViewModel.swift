//
//  ProfileViewModel.swift
//  FakeNFT
//
//  Created by Антон Кашников on 21/10/2023.
//

import UIKit
import Kingfisher

final class ProfileViewModel {
    static let didChangeNotification = Notification.Name(rawValue: "ProfileInfoDidChange")
    static let nftsChangedNotification = Notification.Name(rawValue: "NFTsInfoDidChange")
    
    var profile: Profile?
    var myNFTs: [ItemNFT]?
    var authors: [User]?
    var favoritesNFTs: [ItemNFT]?
    var nfts: [ItemNFT]?
    
    let profileService: ProfileServiceProtocol?
    let viewController: ProfileViewControllerProtocol?
    
    init(viewController: ProfileViewControllerProtocol) {
        self.viewController = viewController
        profileService = ProfileService()
        myNFTs = [ItemNFT]()
        authors = [User]()
        favoritesNFTs = [ItemNFT]()
        nfts = [ItemNFT]()
    }
    
    func getProfile(id: String) {
        profileService?.makeGetProfileRequest(id: id) { [weak self] profile in
            if let profile = profile as? Profile {
                self?.profile = profile
                NotificationCenter.default.post(name: ProfileViewModel.didChangeNotification, object: self)
            }
        }
    }
    
    func updatePhoto(_ imageView: UIImageView) {
        guard let profileImagePath = profile?.avatar else {
            return
        }
        
        let processor = RoundCornerImageProcessor(cornerRadius: 35, backgroundColor: .ypBlack)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: URL(string: profileImagePath), options: [.processor(processor)])
    }
    
    func updateProfileInfo(id: String) {
        profileService?.makePutRequest(id: id, profile: profile) { [weak self] profile in
            if let profile = profile as? Profile {
                self?.profile = profile
                NotificationCenter.default.post(name: ProfileViewModel.didChangeNotification, object: self)
            }
        }
    }
    
    func changeProfileInfo(for field: ProfileInfo, _ string: String) {
        guard let profile else { return }
        
        switch field {
        case .name:
            self.profile = Profile(name: string, avatar: profile.avatar, description: profile.description, website: profile.website, nfts: profile.nfts, likes: profile.likes, id: profile.id)
        case .description:
            self.profile = Profile(name: profile.name, avatar: profile.avatar, description: string, website: profile.website, nfts: profile.nfts, likes: profile.likes, id: profile.id)
        case .website:
            self.profile = Profile(name: profile.name, avatar: profile.avatar, description: profile.description, website: string, nfts: profile.nfts, likes: profile.likes, id: profile.id)
        }
    }
    
    func getPhoto(imageView: UIImageView, index: Int, list: NFTListType) {
        var nft: ItemNFT?
        
        switch list {
        case .my:
            nft = myNFTs?[index]
        case .favorites:
            nft = favoritesNFTs?[index]
        }
        
        guard let nft else { return }
        
        imageView.kf.setImage(
            with: URL(string: nft.images[0]),
            options: [.processor(RoundCornerImageProcessor(cornerRadius: 12, backgroundColor: .ypBlack))]
        )
    }
    
    func getAllNFTs() {
        profileService?.makeGetAllNFTsRequest { [weak self] nfts in
            if let nfts = nfts as? [ItemNFT] {
                self?.nfts = nfts
                self?.getAllAuthors()
            }
        }
    }
    
    func getAllAuthors() {
        profileService?.makeGetAllAuthorsRequest { [weak self] authors in
            if let authors = authors as? [User] {
                self?.authors = authors
                NotificationCenter.default.post(
                    name: ProfileViewModel.nftsChangedNotification,
                    object: self
                )
            }
        }
    }
    
    func sortNFTs() {
        guard let profile else { return }
        
        nfts?.forEach { nft in
            if profile.nfts.contains(nft.id) {
                myNFTs?.append(nft)
            }
            
            if profile.likes.contains(nft.id) {
                favoritesNFTs?.append(nft)
            }
        }
    }
}
