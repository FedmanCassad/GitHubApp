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
  var request: URLRequest
  
  override func loadView() {
    let configuration = WKWebViewConfiguration()
    webView = WKWebView(frame: .zero, configuration: configuration)
    webView.uiDelegate = self
    webView.navigationDelegate = self
    view = webView
  }
  
  init(_ request: URLRequest) {
    self.request = request
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    loadLoginRequest()
  }
  
  func loadLoginRequest() {
    webView.load(request)
  }

}

