//
//  ProfileEditingViewController.swift
//  FakeNFT
//
//  Created by Антон Кашников on 13/10/2023.
//

import UIKit

final class ProfileEditingViewController: UIViewController {
    private let closeButton: UIButton = {
       let button = UIButton()
        button.frame.size = CGSize(width: 42, height: 42)
        button.setImage(UIImage(named: "Close"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "UserPic")
        imageView.frame.size = CGSize(width: 70, height: 70)
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let profileView: UIView = {
        let view = UIView()
        view.backgroundColor = .blackUniversal?.withAlphaComponent(0.6)
        view.frame.size = CGSize(width: 70, height: 70)
        view.layer.cornerRadius = view.frame.size.width / 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let changeProfileImageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .whiteUniversal
        label.text = "Сменить фото"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .ypBlack
        label.text = "Имя"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .ypWhite
        setupCloseButton()
        setupProfileImageView()
        setupProfileView()
        setupChangeProfileImageLabel()
        setupNameLabel()
    }
    
    private func setupCloseButton() {
        closeButton.addTarget(self, action: #selector(closeButtonDidTap), for: .touchUpInside)
        view.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupProfileImageView() {
        view.addSubview(profileImageView)
        
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 70),
            profileImageView.heightAnchor.constraint(equalToConstant: 70),
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            profileImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    private func setupProfileView() {
        profileImageView.addSubview(profileView)
        
        NSLayoutConstraint.activate([
            profileView.widthAnchor.constraint(equalToConstant: 70),
            profileView.heightAnchor.constraint(equalToConstant: 70),
            profileView.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor),
            profileView.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor)
        ])
    }
    
    private func setupChangeProfileImageLabel() {
        profileImageView.addSubview(changeProfileImageLabel)
        
        NSLayoutConstraint.activate([
            changeProfileImageLabel.leadingAnchor.constraint(
                equalTo: profileImageView.leadingAnchor,
                constant: 12
            ),
            changeProfileImageLabel.trailingAnchor.constraint(
                equalTo: profileImageView.trailingAnchor,
                constant: -13
            ),
            changeProfileImageLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor)
        ])
    }
    
    private func setupNameLabel() {
        view.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 24),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    @objc
    private func closeButtonDidTap() {
        dismiss(animated: true)
    }
}
