//
//  CellData.swift
//  GitHubApp
//
//  Created by Vladimir Banushkin on 23.10.2020.
//

import UIKit

struct Repo: Codable {
  let repoName: String
  let repoDescription: String?
  let owner: Owner
  
  enum CodingKeys: String, CodingKey {
    case repoName = "name"
    case repoDescription = "description"
    case owner
  }
  
}
