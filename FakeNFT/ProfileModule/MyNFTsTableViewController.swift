//
//  MyNFTsTableViewController.swift
//  FakeNFT
//
//  Created by Антон Кашников on 19/10/2023.
//

import UIKit

final class MyNFTsTableViewController: UITableViewController {
    var navTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.isHidden = true
        title = navTitle
        
        setupNavigationBar()
        setupTableView()
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
    
    private func setupTableView() {
        let insets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)

        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        tableView.rowHeight = 140
        tableView.separatorStyle = .none
        
        tableView.register(MyNFTsTableViewCell.self, forCellReuseIdentifier: MyNFTsTableViewCell.reuseIdentifier)
    }
    
    @objc
    private func backButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func sortButtonDidTap() {}
}

// MARK: - UITableViewDataSource

extension MyNFTsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: MyNFTsTableViewCell.reuseIdentifier,
            for: indexPath
        )
        return cell
    }
}
