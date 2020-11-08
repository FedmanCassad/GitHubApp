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
    guard let components = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
      return nil
    }
    guard let queryItems = components.queryItems else {
      return nil
    }
    for item in queryItems {
      dict[item.name] = item.value
    }
    return dict
  }
  
}
