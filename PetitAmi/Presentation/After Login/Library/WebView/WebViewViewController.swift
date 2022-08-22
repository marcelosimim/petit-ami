//
//  WebViewViewController.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/22/22.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController, WKNavigationDelegate {
    
    var url: URL?
    private let webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        webView.navigationDelegate = self
        view = webView
        loadContent()
    }

    private func loadContent() {
        guard let url = url else { return }
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }

    private func setupNavBar() {
        navigationController?.navigationBar.tintColor = .background
    }
}
