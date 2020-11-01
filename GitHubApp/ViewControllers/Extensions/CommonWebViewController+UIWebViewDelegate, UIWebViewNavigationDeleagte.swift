//
//  CommonWebViewController+UIWebViewDelegate, UIWebViewNavigationDeleagte.swift
//  GitHubApp
//
//  Created by Vladimir Banushkin on 01.11.2020.
//

import UIKit
import WebKit

extension CommonWebViewScontroller: WKUIDelegate,WKNavigationDelegate, WKScriptMessageHandler {
  func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
    return
  }
  
  
}
