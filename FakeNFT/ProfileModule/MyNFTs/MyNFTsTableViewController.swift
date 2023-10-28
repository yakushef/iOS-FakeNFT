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
        
        if let nfts = profileViewModel?.nfts {
            if nfts.isEmpty {
                UIBlockingProgressHUD.show()
                profileViewModel?.getMyNFTList()
            }
        }
        
        setupNavigationBar()
        setupTableView()
        
        profileObserver = NotificationCenter.default.addObserver(
            forName: ProfileViewModel.nftsDidChangeNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.reloadData()
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
    
    private func reloadData() {
        let filterStatus = UserDefaults.standard.integer(forKey: "indexOfFilter")
        
        switch filterStatus {
        case 0:
            print(0)
            profileViewModel?.nfts?.sort { $0.price < $1.price }
        case 1:
            print(1)
            profileViewModel?.nfts?.sort { $0.rating < $1.rating }
        case 2:
            print(2)
            profileViewModel?.nfts?.sort { $0.name < $1.name }
        default:
            break
        }
        
        tableView.reloadData()
        UIBlockingProgressHUD.dismiss()
    }
    
    private func setFilterType(_ type: Int) {
        UserDefaults.standard.set(type, forKey: "indexOfFilter")
        reloadData()
    }
    
    @objc
    private func backButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func sortButtonDidTap() {
        let alertController = UIAlertController(title: "Сортировка", message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "По цене", style: .default) { [weak self] _ in
            self?.setFilterType(0)
        })
        alertController.addAction(UIAlertAction(title: "По рейтингу", style: .default) { [weak self] _ in
            self?.setFilterType(1)
        })
        alertController.addAction(UIAlertAction(title: "По названию", style: .default) { [weak self] _ in
            self?.setFilterType(2)
        })
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
        
        guard
            let nft = profileViewModel?.nfts?[indexPath.row],
            let authorName = profileViewModel?.authors?[indexPath.row].name
        else {
            return UITableViewCell()
        }
        
        cell.updateNameLabel(nft.name)
        cell.updateRating(nft.rating)
        cell.updatePrice(nft.price)
        cell.updateAuthor(authorName)
        profileViewModel?.getPhoto(imageView: cell.nftImageView, index: indexPath.row)
        
        return cell
    }
}
