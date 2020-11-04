//
//  AppDelegate.swift
//  GitHubApp
//
//  Created by Vladimir Banushkin on 21.10.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
var window: UIWindow?
  
  func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {

    guard  let recievedParameters = url.params() else {return false}
    if let code = recievedParameters["code"] as? String {
      let networkObject = NetworkObject(scheme: .https, host: .GitHub, path: "/login/oauth/access_token")
      networkObject.getAuthorizationToken(code: code) {data in
        guard let data = data else {return}
        let parser = Parser(data: data)
        print(parser.getToken())
        
      }
    }
    let vc = SearchReposViewController()
    if let nav = window?.rootViewController as? UINavigationController {
      nav.pushViewController(vc, animated: true)
    }
    
    return true
  }

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    initiateWindow()
    return true
  }

 func initiateWindow() {
  self.window = UIWindow(frame: UIScreen.main.bounds)
    let loginVC = LoginViewController()
    let navigationController = UINavigationController()
  navigationController.viewControllers = [loginVC]
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()

  }


}

