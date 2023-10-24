//
//  ProfileViewController.swift
//  FakeNFT
//
//  Created by Антон Кашников on 11/10/2023.
//

import UIKit

protocol ProfileViewControllerProtocol {
    var profileImageView: UIImageView { get }
}

final class ProfileViewController: UIViewController, ProfileViewControllerProtocol {
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Userpic_Placeholder")
        imageView.frame.size = CGSize(width: 70, height: 70)
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let profileNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Bold.medium
        return label
    }()
    
    private let profileBioLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private let siteLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Regular.medium
        return label
    }()
    
    private let profileTableView: UITableView = {
        let tableView = UITableView()
        tableView.isScrollEnabled = false
        tableView.rowHeight = 54
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ProfileCell")
        return tableView
    }()
    
    private let cells = ["Мои NFT", "Избранные NFT", "О разработчике"]
    
    private var profileViewModel: ProfileViewModel?
    private var profileObserver: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .ypWhite
        
        profileViewModel = ProfileViewModel(viewController: self)
        
        profileObserver = NotificationCenter.default.addObserver(
            forName: ProfileViewModel.didChangeNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.updateProfileInfo()
        }
        
        profileViewModel?.getProfile()
        
        setupView()
        setupNavigationBar()
        setupProfileImageView()
        setupProfileNameLabel()
        setupBioLabel()
        setupSiteLabel()
        setupProfileTableView()
        
        addGesture()
    }
    
    private func updateProfileInfo() {
        profileNameLabel.text = profileViewModel?.profile?.name
        profileViewModel?.updatePhoto(profileImageView)
        
        guard let description = profileViewModel?.profile?.description, let website = profileViewModel?.profile?.website else {
            return
        }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 18
        
        let attrString = NSMutableAttributedString(string: description)
        let range = NSMakeRange(0, attrString.length)
        
        attrString.addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
        attrString.addAttribute(.font, value: UIFont.Regular.small ?? UIFont.systemFont(ofSize: 13), range: range)
        
        profileBioLabel.attributedText = attrString
        
        let attributedString = NSMutableAttributedString(string: website)
        attributedString.addAttribute(.link, value: website, range: NSMakeRange(0, attributedString.length))
        siteLabel.attributedText = attributedString
        
        view.layoutIfNeeded()
    }
    
    private func addGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(labelTapped(_:)))
        tap.numberOfTapsRequired = 1
        siteLabel.isUserInteractionEnabled = true
        siteLabel.addGestureRecognizer(tap)
    }
    
    private func openWebView() {
        let webViewController = WebViewController()
        webViewController.selectedWebSite = profileViewModel?.profile?.website
        navigationController?.pushViewController(webViewController, animated: true)
    }
    
    private func setupView() {
        [profileImageView, profileNameLabel, profileBioLabel, siteLabel, profileTableView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "Edit"),
            style: .done,
            target: self,
            action: #selector(editButtonDidTap)
        )
    }
    
    private func setupProfileImageView() {
        view.addSubview(profileImageView)
        
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 70),
            profileImageView.heightAnchor.constraint(equalToConstant: 70),
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            profileImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ])
    }
    
    private func setupProfileNameLabel() {
        view.addSubview(profileNameLabel)
        
        NSLayoutConstraint.activate([
            profileNameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            profileNameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            profileNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupBioLabel() {
        view.addSubview(profileBioLabel)
        
        NSLayoutConstraint.activate([
            profileBioLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            profileBioLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            profileBioLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -18)
        ])
    }
    
    private func setupSiteLabel() {
        view.addSubview(siteLabel)
        
        NSLayoutConstraint.activate([
            siteLabel.topAnchor.constraint(equalTo: profileBioLabel.bottomAnchor, constant: 12),
            siteLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            siteLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupProfileTableView() {
        profileTableView.separatorStyle = .none
        profileTableView.dataSource = self
        profileTableView.delegate = self
        view.addSubview(profileTableView)
        
        NSLayoutConstraint.activate([
            profileTableView.topAnchor.constraint(equalTo: siteLabel.bottomAnchor, constant: 40),
            profileTableView.heightAnchor.constraint(
                equalToConstant: profileTableView.rowHeight * CGFloat(cells.count)
            ),
            profileTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    @objc
    private func editButtonDidTap() {
        let profileEditingViewController = ProfileEditingViewController()
        profileEditingViewController.profileViewModel = profileViewModel
        present(profileEditingViewController, animated: true)
    }
    
    @objc
    private func labelTapped(_ tap: UITapGestureRecognizer) {
        openWebView()
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath)
        cell.accessoryView = UIImageView(image: UIImage(named: "chevron.forward"))
        cell.selectionStyle = .none
        
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = cells[indexPath.row]
            content.textProperties.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            cell.contentConfiguration = content
        } else {
            cell.textLabel?.text = cells[indexPath.row]
            cell.textLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        }
        
        return cell
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let myNFTsTableViewController = MyNFTsTableViewController()
            myNFTsTableViewController.navTitle = cells[indexPath.row]
            navigationController?.pushViewController(myNFTsTableViewController, animated: true)
        case 1:
            let favoritesNFTsCollectionViewController = FavoritesNFTsCollectionViewController()
            favoritesNFTsCollectionViewController.navTitle = cells[indexPath.row]
            navigationController?.pushViewController(favoritesNFTsCollectionViewController, animated: true)
        case 2:
            openWebView()
        default:
            break
        }
    }
}
