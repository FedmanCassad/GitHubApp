//
//  SearchReposViewController+FaceIdChecking.swift
//  GitHubApp
//
//  Created by Vladimir Banushkin on 11.11.2020.
//

import LocalAuthentication

extension SearchReposViewController {
  
  func checkingCridentialsMainFlow() {
    let networkObject = NetworkObject(scheme: .https, host: .GitHub, path: "/login/oauth/access_token")
    guard let tempCode = KeyChainService.recieve(key: "temporaryCode") else {
      navigateBackToLoginScreen()
      return
    }
    if let token = KeyChainService.recieve(key: "accessToken") {
      if let currentUser = user {
        helloLabel.text = "Hello, \(currentUser.login)!"
        avatarImage.kf.setImage(with: URL(string: currentUser.avatarURL))
      } else {
        networkObject.getCurrentUser(token: token) { [weak self] user in
          guard let self = self, let user = user else {return}
          DispatchQueue.main.async {
            self.user = user
          }
        }
      }
      
    } else {
      if let strigyfiedCode = String(data: tempCode, encoding: .utf8) {
        networkObject.getAuthorizationToken(code: strigyfiedCode) { [weak self] data in
          guard let self = self else {return}
          guard let data = data else {return}
          guard let token = Parser.getToken(data) else
          {
            DispatchQueue.main.async {
              self.navigateBackToLoginScreen()
            }
            return
          }
          let _ = KeyChainService.save(key: "accessToken", data: token)
          networkObject.getCurrentUser(token: token) { user in
            DispatchQueue.main.async {
              self.user = user
            }
          }
        }
      }
    }
  }
  
  func performFaceIdCheck()  {
    let biometrySecurityChecker = FaceIdWrapper()
    biometrySecurityChecker.authenticateUser { [weak self] isRecognized in
      guard let self = self else
      {return}
      if isRecognized{
        self.checkingCridentialsMainFlow()
      }
      else {
        self.navigateBackToLoginScreen()
      }
    }
  }
  
}
