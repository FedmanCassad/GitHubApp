//
//  KeychainService.swift
//  GitHubApp
//
//  Created by Vladimir Banushkin on 04.11.2020.
//

import Security
import Foundation

class KeyChainService: SensitiveDataWrapper {
  static let server = "github.com"
  
  static func save(key: String, data: Data) -> OSStatus {
    let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                kSecAttrAccount as String: key,
                                kSecAttrServer as String: server,
                                kSecValueData as String: data]
    SecItemDelete(query as CFDictionary)
    return SecItemAdd(query as CFDictionary, nil)
  }
  
  static func recieve(key: String) -> Data? {
    let query = [
      kSecClass as String: kSecClassInternetPassword,
      kSecAttrAccount as String: key,
      kSecReturnData as String: kCFBooleanTrue!,
      kSecMatchLimit as String: kSecMatchLimitOne ] as [String : Any]
    var dataTypeRef: AnyObject? = nil
    let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
    if status == noErr {
      return dataTypeRef as! Data?
    } else {
      return nil
    }
  }
  
}
