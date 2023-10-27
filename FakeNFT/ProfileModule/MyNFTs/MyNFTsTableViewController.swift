//
//  MyNFTsTableViewController.swift
//  FakeNFT
//
//  Created by Антон Кашников on 19/10/2023.
//

import UIKit

final class MyNFTsTableViewController: UITableViewController {
    var profileViewModel: ProfileViewModel?
    var navTitle: String?
    
    private var profileObserver: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.isHidden = true
        title = navTitle
        
        profileViewModel?.getMyNFTList()
        
        setupNavigationBar()
        setupTableView()
        
        profileObserver = NotificationCenter.default.addObserver(
            forName: ProfileViewModel.nftsDidChangeNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.tableView.reloadData()
            print(self?.profileViewModel?.nfts?.count)
            print(self?.profileViewModel?.nfts)
        }
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
    private func sortButtonDidTap() {
        let alertController = UIAlertController(title: "Сортировка", message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "По цене", style: .default, handler: nil))
        alertController.addAction(UIAlertAction(title: "По рейтингу", style: .default, handler: nil))
        alertController.addAction(UIAlertAction(title: "По названию", style: .default, handler: nil))
        alertController.addAction(UIAlertAction(title: "Закрыть", style: .cancel))
        present(alertController, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension MyNFTsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        profileViewModel?.nfts?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MyNFTsTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? MyNFTsTableViewCell else { return UITableViewCell() }
        
        guard let nft = profileViewModel?.nfts?[indexPath.row] else { return UITableViewCell() }
        
        cell.updateNameLabel(nft.name)
        cell.updateRating(nft.rating)
        cell.updatePrice(nft.price)
        cell.updateAuthor(profileViewModel?.authors?[indexPath.row].name ?? "")
        
        return cell
    }
}
