//
//  File.swift
//  GitHubApp
//
//  Created by Vladimir Banushkin on 27.10.2020.
//

import Foundation

class RepoParser {
  private var data: Data
  
  init(data: Data) {
    self.data = data
  }
  
  func getRepos() ->[Repo]? {
    let decoder = JSONDecoder()
    decoder.dataDecodingStrategy = .deferredToData
    guard let result = try? decoder.decode(Repos.self, from: data) else {
      return nil
    }
    return result.repos
  }
  
}
