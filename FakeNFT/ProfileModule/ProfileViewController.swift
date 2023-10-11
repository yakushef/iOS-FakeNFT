//
//  ProfileViewController.swift
//  FakeNFT
//
//  Created by Антон Кашников on 11/10/2023.
//

import UIKit

final class ProfileViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .ypWhite
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Edit"), style: .done, target: self, action: #selector(editButtonDidTap))
    }
    
    @objc
    private func editButtonDidTap() {
        
    }
}
