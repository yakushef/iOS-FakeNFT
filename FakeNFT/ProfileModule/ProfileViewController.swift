//
//  ProfileViewController.swift
//  FakeNFT
//
//  Created by Антон Кашников on 11/10/2023.
//

import UIKit

final class ProfileViewController: UIViewController {
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "UserPic")
        imageView.frame.size = CGSize(width: 70, height: 70)
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let profileNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Joaquin Phoenix"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let profileBioLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        
        let text = "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям."
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 18
        
        let attrString = NSMutableAttributedString(string: text)
        let range = NSMakeRange(0, attrString.length)
        
        attrString.addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
        attrString.addAttribute(.font, value: UIFont.systemFont(ofSize: 13), range: range)
        
        label.attributedText = attrString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let siteLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        let attributedString = NSMutableAttributedString(string: "Joaquin Phoenix.com")
        if attributedString.setAsLink(textToFind: "Joaquin Phoenix.com", linkURL: "JoaquinPhoenix.com") {
            label.attributedText = attributedString
        }
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let profileTableView: UITableView = {
        let tableView = UITableView()
        tableView.isScrollEnabled = false
        tableView.rowHeight = 54
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ProfileCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let cells = ["Мои NFT", "Избранные NFT", "О разработчике"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .ypWhite
        setupNavigationBar()
        setupContainerView()
        setupProfileImageView()
        setupProfileNameLabel()
        setupBioTextField()
        setupSiteLabel()
        setupProfileTableView()
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "Edit"),
            style: .done,
            target: self,
            action: #selector(editButtonDidTap)
        )
    }
    
    private func setupContainerView() {
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 162),
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setupProfileImageView() {
        containerView.addSubview(profileImageView)
        
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 70),
            profileImageView.heightAnchor.constraint(equalToConstant: 70),
            profileImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16)
        ])
    }
    
    private func setupProfileNameLabel() {
        containerView.addSubview(profileNameLabel)
        
        NSLayoutConstraint.activate([
            profileNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 21),
            profileNameLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -113),
            profileNameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            profileNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
    private func setupBioTextField() {
        containerView.addSubview(profileBioLabel)
        
        NSLayoutConstraint.activate([
            profileBioLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 90),
            profileBioLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            profileBioLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            profileBioLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -18)
        ])
    }
    
    private func setupSiteLabel() {
        view.addSubview(siteLabel)
        
        NSLayoutConstraint.activate([
            siteLabel.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 12),
            siteLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            siteLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupProfileTableView() {
        profileTableView.separatorStyle = .none
        profileTableView.dataSource = self
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
        present(ProfileEditingViewController(), animated: true)
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
