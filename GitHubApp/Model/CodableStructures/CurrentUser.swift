//
//  CurrentUser.swift
//  GitHubApp
//
//  Created by Vladimir Banushkin on 04.11.2020.
//

import Foundation

struct CurrentUser {
 var login: String
 var avatarURl: String
  
  enum CodingKeys: String, CodingKey {
    case login
    case avatarURL = "avatar_url"
  }

}
