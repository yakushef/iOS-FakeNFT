//
//  ProfileViewModel.swift
//  FakeNFT
//
//  Created by Антон Кашников on 21/10/2023.
//

import Foundation
import Kingfisher

final class ProfileViewModel {
    var profile: Profile?
    let profileService = ProfileService()
    let viewController: ProfileViewController?
    
    init(viewController: ProfileViewController) {
        self.viewController = viewController
    }
    
    static let didChangeNotification = Notification.Name(rawValue: "ProfileInfoDidChange")
    
    func getProfile() {
        profileService.makeRequest { [weak self] profile in
            self?.profile = profile
            NotificationCenter.default.post(name: ProfileViewModel.didChangeNotification, object: self)
        }
    }
    
    func updatePhoto() {
        guard let profileImagePath = profile?.avatar else {
            return
        }

        let processor = RoundCornerImageProcessor(cornerRadius: 35, backgroundColor: .ypBlack)
        viewController?.profileImageView.kf.indicatorType = .activity
        viewController?.profileImageView.kf.setImage(with: URL(string: profileImagePath), options: [.processor(processor)])
    }
}
