//
//  CommonWebViewController.swift
//  GitHubApp
//
//  Created by Vladimir Banushkin on 01.11.2020.
//

import UIKit
import  WebKit

class CommonWebViewScontroller: UIViewController {
  
  var webView: WKWebView!
  var url: URL
  
  override func loadView() {
    let configuration = WKWebViewConfiguration()
    webView = WKWebView(frame: .zero, configuration: configuration)
    webView.translatesAutoresizingMaskIntoConstraints = false
    webView.uiDelegate = self
    webView.navigationDelegate = self
    view = webView
  }
  
  init(_ url: URL) {
    self.url = url
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    let request = URLRequest(url: url)
    webView.load(request)
  }
  
}

