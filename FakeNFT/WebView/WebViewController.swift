//
//  WebViewController.swift
//  FakeNFT
//
//  Created by Aleksey Yakushev on 22.10.2023.
//

import ProgressHUD
import UIKit
import WebKit

final class WebViewController: UIViewController {
    var model: WebViewModel?
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.accessibilityIdentifier = "web_view"
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        if let request = model?.makeRequest() {
            webView.load(request)
            ProgressHUD.show()
        }
    }
    
    private func setupUI() {
        hidesBottomBarWhenPushed = true
        view.backgroundColor = .ypWhite
        
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
    
    @objc
    private func backButtonTapped() {
        ProgressHUD.dismiss()
        navigationController?.popViewController(animated: true)
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        ProgressHUD.dismiss()
    }
}
