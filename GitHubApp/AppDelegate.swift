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
    
   let controller =  window?.rootViewController as! UINavigationController
    let searchVC = SearchReposViewController()
    controller.viewControllers = [searchVC]
    
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

