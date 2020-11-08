//
//  UIViewController+CommonAlert.swift
//  GitHubApp
//
//  Created by Vladimir Banushkin on 01.11.2020.
//

import UIKit

extension UIViewController {
  
  func alert(completion: ((UIViewController) -> ())?) {
    let alertController = UIAlertController(title: "Unknown error!", message: "Please try again later", preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    self.present(alertController, animated: true, completion: nil)
  }
  
}
