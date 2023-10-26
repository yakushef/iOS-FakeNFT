//
//  ProfileViewModel.swift
//  FakeNFT
//
//  Created by Антон Кашников on 21/10/2023.
//

import UIKit
import Kingfisher

final class ProfileViewModel {
    var profile: Profile?
    
    let profileService: ProfileServiceProtocol?
    let viewController: ProfileViewControllerProtocol?
    
    init(viewController: ProfileViewControllerProtocol) {
        self.viewController = viewController
        profileService = ProfileService()
    }
    
    static let didChangeNotification = Notification.Name(rawValue: "ProfileInfoDidChange")
    
    func getProfile() {
        profileService?.makeRequest { [weak self] profile in
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
}
