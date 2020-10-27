//
//  CellData.swift
//  GitHubApp
//
//  Created by Vladimir Banushkin on 23.10.2020.
//

import UIKit

struct Repo {
  var repoName: String
  var repoDescription: String?
  var authorName: String
  var avatarImage: UIImage

  init(repoName: String, repoDescription: String?, authorName: String, avatarImage: UIImage ) {
    self.repoName = repoName
    self.authorName = authorName
    self.avatarImage = avatarImage
    guard let repoDescr = repoDescription else {return}
    self.repoDescription = repoDescr
  }
  
}
