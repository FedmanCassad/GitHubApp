//
//  TotalCount.swift
//  GitHubApp
//
//  Created by Vladimir Banushkin on 25.10.2020.
//
import UIKit

struct Owner: Codable {
  let login: String
  let  avatarURL: URL
  
  private enum CodingKeys: String, CodingKey {
    case login
    case avatarURL = "avatar_url"
  }
  
}
