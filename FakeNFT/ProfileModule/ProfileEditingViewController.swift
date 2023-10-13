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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .ypWhite
        setupCloseButton()
    }
    
    private func setupCloseButton() {
        closeButton.addTarget(self, action: #selector(closeButtonDidTap), for: .touchUpInside)
        view.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    @objc
    private func closeButtonDidTap() {
        dismiss(animated: true)
    }
}
