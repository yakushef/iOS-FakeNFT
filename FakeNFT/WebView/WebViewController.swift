//
//  WebViewController.swift
//  FakeNFT
//
//  Created by Aleksey Yakushev on 22.10.2023.
//

import UIKit
import WebKit

final class WebViewController: UIViewController {
    var model: WebViewModel?
    
    private let webView: WKWebView = {
        WKWebView()
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activitiIndicator = UIActivityIndicatorView(style: .medium)
        activitiIndicator.color = .ypBlack
        activitiIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activitiIndicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupActivityIndicator()
        
        if let request = model?.makeRequest() {
            webView.load(request)
            activityIndicator.startAnimating()
        }
    }
    
    private func setupUI() {
        hidesBottomBarWhenPushed = true
        view.backgroundColor = .ypWhite
        tabBarController?.tabBar.isHidden = true
        
        view.addSubview(webView)
        webView.frame = view.safeAreaLayoutGuide.layoutFrame
        webView.navigationDelegate = self
        
        let backButton = UIBarButtonItem(image: UIImage(named: "Backward"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(backButtonTapped))
        backButton.tintColor = .ypBlack
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func setupActivityIndicator() {
        webView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: webView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: webView.centerYAnchor)
        ])
    }
    
    @objc
    private func backButtonTapped() {
        activityIndicator.stopAnimating()
        navigationController?.popViewController(animated: true)
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
}
