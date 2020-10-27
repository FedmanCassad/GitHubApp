//
//  UIImageView+makeRounded.swift
//  GitHubApp
//
//  Created by Vladimir Banushkin on 22.10.2020.
//

import UIKit

extension UIImageView {
  
    func makeRounded() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
