//
//  MyNFTsViewController.swift
//  FakeNFT
//
//  Created by Антон Кашников on 19/10/2023.
//

import UIKit

final class MyNFTsViewController: UIViewController {
    var navTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .ypWhite
        tabBarController?.tabBar.isHidden = true
        title = navTitle
        
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "Backward"),
            style: .plain,
            target: self,
            action: #selector(backButtonDidTap)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "Sort"),
            style: .plain,
            target: self,
            action: #selector(sortButtonDidTap)
        )
    }
    
    @objc
    private func backButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func sortButtonDidTap() {}
}
