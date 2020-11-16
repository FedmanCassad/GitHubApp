//
//  AppDelegate.swift
//  GitHubApp
//
//  Created by Vladimir Banushkin on 21.10.2020.
//

import UIKit
import Security

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    guard  let recievedParameters = url.params() else {
      return false
    }
    if let code = recievedParameters["code"] as? String {
      if let codeData = code.data(using: .utf8){
        let _ =  KeyChainService.save(key: "temporaryCode", data: codeData)
      }
    }
    
    if let nav = window?.rootViewController as? UINavigationController {
      let searchVC = SearchReposViewController()
      nav.pushViewController(searchVC, animated: true)
    }
    return true
  }
  
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    self.initiateWindow()
    return true
  }
  
  func initiateWindow() {
    window = UIWindow(frame: UIScreen.main.bounds)
    let navigationController = UINavigationController()
    let searchVC = SearchReposViewController()
    navigationController.viewControllers = [searchVC]
    self.window?.rootViewController = navigationController
    self.window?.makeKeyAndVisible()
  }
  
}


