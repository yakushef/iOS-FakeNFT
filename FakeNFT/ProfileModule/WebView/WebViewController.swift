//
//  WebViewController.swift
//  FakeNFT
//
//  Created by Антон Кашников on 18/10/2023.
//

import WebKit

final class WebViewController: UIViewController {
    private var webView: WKWebView!
    
    var selectedWebSite: String?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.isHidden = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Backward"), style: .plain, target: self, action: #selector(backButtonDidTap))
        
        if let url = URL(string: selectedWebSite ?? "") {
            webView.load(URLRequest(url: url))
        }
    }
    
    @objc
    private func backButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
}
