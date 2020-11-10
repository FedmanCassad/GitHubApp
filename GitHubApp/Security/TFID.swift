//
//  TFID.swift
//  GitHubApp
//
//  Created by Vladimir Banushkin on 09.11.2020.
//


import LocalAuthentication
import UIKit

class TFID {
  
  private func didUserHasToken () -> Bool {
    guard let _ = KeyChainService.recieve(key: "temporaryCode")
    else {return false}
    return true
  }
  
  func authenticateUser(completion: @escaping (Bool) -> Void){
    guard didUserHasToken() else {
      completion(false)
      return
    }
    
    if #available(iOS 8.0, *, *) {
      let authenticationContext = LAContext()
      authenticationContext.localizedReason = "Use for fast and safe authentication in your app"
      authenticationContext.localizedCancelTitle = "Cancel"
      authenticationContext.localizedFallbackTitle = "Enter password"
      authenticationContext.touchIDAuthenticationAllowableReuseDuration = 100
      let reason = "Fast and safe authentication in your app"
      var authError: NSError?
      if authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
        authenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, evaluateError in
          DispatchQueue.main.async {
            if success {
              completion(true)
            } else {
              if let error = evaluateError {
                print(error.localizedDescription)
                completion(false)
              }
            }
          }
        }
      } else {
        if let error = authError {
          print(error.localizedDescription)
        }
        completion(false)
      }
    }
  }
  
}


