//
//  File.swift
//  GitHubApp
//
//  Created by Vladimir Banushkin on 27.10.2020.
//

import Foundation

class Parser {
  
  static func getToken(_ data: Data) -> Data? {
    var token = String()
    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]{
      if let jsonToken = json["access_token"] as? String {
        token = jsonToken
        return token.data(using: .utf8)
      }
    }
    return nil
  }
  
  static func getRepos(_ data: Data) -> [Repo]? {
    let decoder = JSONDecoder()
    decoder.dataDecodingStrategy = .deferredToData
    guard let result = try? decoder.decode(Repos.self, from: data) else {
      return nil
    }
    print(result.repos)
    return result.repos
  }
  
}
