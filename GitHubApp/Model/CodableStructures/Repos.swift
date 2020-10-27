//
//  Repos.swift
//  GitHubApp
//
//  Created by Vladimir Banushkin on 25.10.2020.
//

import UIKit

struct Repos: Codable {
  let repos: [Repo]
  
  enum CodingKeys: String, CodingKey {
    case repos = "items"
  }
  
}
