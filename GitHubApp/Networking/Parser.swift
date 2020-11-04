//
//  File.swift
//  GitHubApp
//
//  Created by Vladimir Banushkin on 27.10.2020.
//

import Foundation

class Parser {
  private var data: Data
  
  init(data: Data) {
    self.data = data
  }
  
  func getToken() -> String? {
    var token = String()
    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]{
      if let jsonToken = json["access_token"] as? String {
        token = jsonToken
        return token
      }
    }
    return nil
  }
  
  func getRepos() -> [Repo]? {
    let decoder = JSONDecoder()
    decoder.dataDecodingStrategy = .deferredToData
    guard let result = try? decoder.decode(Repos.self, from: data) else {
      return nil
    }
    return result.repos
  }
  
}
