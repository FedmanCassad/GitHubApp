//
//  ViewController.swift
//  GitHubApp
//
//  Created by Vladimir Banushkin on 21.10.2020.
//

import UIKit
import Kingfisher
import WebKit

class LoginViewController: UIViewController {
  
  var logo: UIImageView!
  var usernameField: UITextField!
  var passwordField: UITextField!
  var loginButton: UIButton!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    logo = .init()
    usernameField = .init()
    passwordField = .init()
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
    configureTextField(usernameField)
    configureTextField(passwordField)
    usernameField.frame.origin.y = logo.frame.maxY + 100
    passwordField.frame.origin.y = usernameField.frame.maxY + 10
    usernameField.placeholder = "Username"
    usernameField.overrideUserInterfaceStyle = .light
    passwordField.placeholder = "Password"
    passwordField.overrideUserInterfaceStyle = .light
    loginButton.setTitleColor(.systemTeal, for: .normal)
    loginButton.setTitle("Login", for: .normal)
    loginButton.sizeToFit()
    loginButton.layer.cornerRadius = .pi
    loginButton.center.x = logo.center.x
    loginButton.frame.origin.y = passwordField.frame.maxY + 20
    let url = URL(string: "https://github.githubassets.com/images/modules/logos_page/GitHub-Logo.png")!
    logo.kf.setImage(with: url)
    view.addSubview(logo)
    view.addSubview(usernameField)
    view.addSubview(passwordField)
    view.addSubview(loginButton)
  }
  
  private func configureTextField(_ textField: UITextField) {
    textField.frame.size = CGSize(width: view.frame.width - 140, height: 35)
    textField.center.x = logo.center.x
    textField.borderStyle = .roundedRect
  }
  
  @objc func goToSearchrepoVC() {
    
    let networkObject = NetworkObject(scheme: .https, host: .GitHub, path: "/login/oauth/authorize")
    guard let request = networkObject.AuthenticationRequest() else {return}
    let webViewController = CommonWebViewScontroller(request)

    navigationController?.pushViewController(webViewController, animated: true)
  }
  
}

