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
    static let nftsDidChangeNotification = Notification.Name(rawValue: "NFTsDidChange")
    
    var profile: Profile?
    var nfts: [ItemNFT]?
    var authors: [User]?
    
    let profileService: ProfileServiceProtocol?
    let viewController: ProfileViewControllerProtocol?
    
    init(viewController: ProfileViewControllerProtocol) {
        self.viewController = viewController
        profileService = ProfileService()
        nfts = [ItemNFT]()
        authors = [User]()
    }
    
    func getProfile(id: String) {
        profileService?.makeGetProfileRequest(id: id) { [weak self] profile in
            if let profile = profile as? Profile {
                self?.profile = profile
                NotificationCenter.default.post(name: ProfileViewModel.didChangeNotification, object: self)
            }
        }
    }
    
    func getUser(id: String, _ handler: @escaping (User) -> Void) {
        profileService?.makeGetUserRequest(id: id) { user in
            if let user = user as? User {
                handler(user)
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
    
    func getMyNFTList() {
        profile?.nfts.forEach { nft in
            profileService?.makeGetNFTListRequest(id: nft) { [weak self] itemNFT in
                if let self, let itemNFT = itemNFT as? ItemNFT {
                    self.nfts?.append(itemNFT)
                    
                    // TODO: надо придумать как сделать так, чтобы уведомление отправлялось только когда все NFT загрузились а не после каждого запроса на новую NFT
                    if self.nfts?.count == self.profile?.nfts.count {
                        getAuthors()
                    }
                }
            }
        }
        

    }
    
    func getAuthors() {
        nfts?.forEach { nft in
            getUser(id: nft.author) { [weak self] user in
                self?.authors?.append(user)
                if self?.authors?.count == self?.profile?.nfts.count {
                    print("PRINT AUTHORS")
                    print(self?.authors?.count)
                    print(self?.authors)
                    NotificationCenter.default.post(name: ProfileViewModel.nftsDidChangeNotification, object: self)
                }
            }
        }
    }
}
