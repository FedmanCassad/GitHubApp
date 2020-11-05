//
//  ViewController.swift
//  GitHubApp
//
//  Created by Vladimir Banushkin on 21.10.2020.
//

import UIKit
import Kingfisher
import WebKit
import SafariServices

class LoginViewController: UIViewController {
  
  var logo: UIImageView!
  var loginButton: UIButton!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    logo = .init()
  
    loginButton = .init()
    loginButton.addTarget(self, action: #selector(goToSearchrepoVC), for: .touchUpInside)
    logo.contentMode = .scaleAspectFit
    view.backgroundColor = .white
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    layoutSubviews()
  }
  
  private func layoutSubviews () {
    logo.frame = CGRect(x: 16, y: view.safeAreaInsets.top + 150, width: view.frame.width - 100, height: 50)
    logo.center.x = view.center.x
    loginButton.setTitleColor(.systemTeal, for: .normal)
    loginButton.setTitle("Login via Github", for: .normal)
    loginButton.sizeToFit()
    loginButton.layer.cornerRadius = .pi
    loginButton.center.x = logo.center.x
    loginButton.center = view.center
    let url = URL(string: "https://github.githubassets.com/images/modules/logos_page/GitHub-Logo.png")!
    logo.kf.setImage(with: url)
    view.addSubview(logo)
    view.addSubview(loginButton)
  }
  

  
  @objc func goToSearchrepoVC() {
    
    let networkObject = NetworkObject(scheme: .https, host: .GitHub, path: "/login/oauth/authorize")
    guard let url = networkObject.initialAuthenticationRequest()?.url else {return}
    UIApplication.shared.open(url)
  }
  
}

