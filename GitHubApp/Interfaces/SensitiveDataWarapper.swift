//
//  SensitiveDataWarapper.swift
//  GitHubApp
//
//  Created by Vladimir Banushkin on 04.11.2020.
//

import Foundation
import Security

protocol SensitiveDataWrapper {
  static func save(key: String, data: Data) -> OSStatus
  static func recieve(key: String) -> Data?
}
