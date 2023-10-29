//
//  CollectionItemViewController.swift
//  FakeNFT
//
//  Created by Andy Kruch on 22.10.23.
//

import UIKit

final class ProductDetailsTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(ProductDetailsTableViewCell.self)
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProductDetailsTableViewCell = tableView.dequeueReusableCell()

        cell.textLabel?.text = "Ячейка номер \(indexPath.row)"

        return cell
    }
    
    private func setupNavBar() {
        if let navBar = navigationController?.navigationBar {
            let leftImageButton = UIImage(systemName: "chevron.backward")?
                .withTintColor(.black)
                .withRenderingMode(.alwaysOriginal)
            let leftBarButton = UIBarButtonItem(
                image: leftImageButton,
                style: .plain,
                target: self,
                action: #selector(self.leftNavigationBarButtonTapped)
            )
            navigationItem.leftBarButtonItem = leftBarButton
            navBar.tintColor = .black
            navBar.isTranslucent = true
        }
    }
    
    @objc private func leftNavigationBarButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

