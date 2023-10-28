//
//  MyNFTsTableViewController.swift
//  FakeNFT
//
//  Created by Антон Кашников on 19/10/2023.
//

import UIKit

final class MyNFTsTableViewController: UIViewController {
    var profileViewModel: ProfileViewModel?
    var navTitle: String?
    
    private var profileObserver: NSObjectProtocol?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 140
        tableView.separatorStyle = .none
        tableView.register(MyNFTsTableViewCell.self, forCellReuseIdentifier: MyNFTsTableViewCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let label: UILabel = {
        let label = UILabel(text: "У Вас ещё нет NFT")
        label.font = UIFont.Bold.small
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .ypWhite
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
        setupLabel()
        
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
        tableView.dataSource = self
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setupLabel() {
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
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
        reloadPlaceholderView()
    }
    
    private func reloadPlaceholderView() {
        if let nfts = profileViewModel?.nfts {
            if nfts.isEmpty {
                tableView.isHidden = true
                
                view.backgroundColor = .ypWhite
                label.isHidden = false
            }
        }
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

extension MyNFTsTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        profileViewModel?.nfts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
