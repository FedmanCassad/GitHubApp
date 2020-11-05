//
//  URL+EasyParametersExtruder.swift
//  GitHubApp
//
//  Created by Vladimir Banushkin on 04.11.2020.
//

import Foundation

extension URL {
  func params() -> [String:Any]? {
    var dict = [String:Any]()
    
    if let components = URLComponents(url: self, resolvingAgainstBaseURL: false) {
      if let queryItems = components.queryItems {
        for item in queryItems {
          dict[item.name] = item.value
        }
      }
      return dict
    } else {
      return nil
    }
  }
  
}
