//
//  DeleteConfirmationViewController.swift
//  FakeNFT
//
//  Created by Aleksey Yakushev on 16.10.2023.
//

import UIKit


final class DeleteConfirmationViewController: UIViewController {
    var removalAction: () -> Void = { }
    var nftImageURL: String? {
        didSet {
            if let url = nftImageURL {
                nftView.kf.setImage(with: URL(string: url)!,
                                    placeholder: UIImage(named: "NFT_Placeholder"),
                                    options: [.transition (.fade (0.3))])
            }
        }
    }
    
    //MARK: - UI elements
    
    private lazy var nftView: UIImageView = {
        let nftView = UIImageView()
        nftView.image = UIImage(named: "NFT_Placeholder")
        nftView.contentMode = .scaleAspectFill
        nftView.heightAnchor.constraint(equalToConstant: 108).isActive = true
        nftView.widthAnchor.constraint(equalToConstant: 108).isActive = true
        nftView.clipsToBounds = true
        nftView.layer.cornerRadius = 12
        return nftView
    }()
    
    private lazy var alertText: UILabel = {
        let alertText = UILabel()
        alertText.font = .Regular.small
        alertText.numberOfLines = 2
        alertText.text = "Вы уверены, что хотите\nудалить объект из корзины?"
        alertText.textAlignment = .center
        alertText.textColor = .ypBlack
        return alertText
    }()
    
    private lazy var buttonStack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fillEqually
        stack.widthAnchor.constraint(equalToConstant: 262).isActive = true
        stack.heightAnchor.constraint(equalToConstant: 44).isActive = true
        return stack
    }()
    
    private lazy var cancelButton: UIButton = {
        let cancelButton = GenericButton(type: .system)
        cancelButton.addTarget(self,
                               action: #selector(cancelButtonTapped),
                               for: .touchUpInside)
        cancelButton.titleLabel?.font = .Regular.large
        cancelButton.setTitle("Вернуться", for: .normal)
        cancelButton.layer.cornerRadius = CornerRadius.medium.cgFloat()
        return cancelButton
    }()
    
    private lazy var removeButton: UIButton = {
        let cancelButton = GenericButton(type: .system)
        cancelButton.addTarget(self,
                               action: #selector(removeButtonTapped),
                               for: .touchUpInside)
        cancelButton.titleLabel?.font = .Regular.large
        cancelButton.setTitleColor(.redUniversal, for: .normal)
        cancelButton.setTitle("Удалить", for: .normal)
        cancelButton.layer.cornerRadius = CornerRadius.medium.cgFloat()
        return cancelButton
    }()

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    //MARK: UI setup
    
    private func setupUI() {
        view.backgroundColor = .clear
        
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        view.addSubview(blurEffectView)
        
        view.addSubview(nftView)
        nftView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nftView.topAnchor.constraint(equalTo: view.topAnchor, constant: 244),
            nftView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(alertText)
        alertText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            alertText.topAnchor.constraint(equalTo: nftView.bottomAnchor, constant: 12),
            alertText.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(buttonStack)
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStack.topAnchor.constraint(equalTo: alertText.bottomAnchor, constant: 20),
            buttonStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        buttonStack.addArrangedSubview(removeButton)
        buttonStack.addArrangedSubview(cancelButton)
    }
    
    //MARK: - Button interaction
    
    @objc private func removeButtonTapped() {
        dismiss(animated: true, completion: removalAction)
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true)
    }
}
