//
//  Networking.swift
//  GitHubApp
//
//  Created by Vladimir Banushkin on 22.10.2020.
//

import UIKit
import Kingfisher

class NetworkObject {
  private var scheme: ConnectionScheme
  private var host: KnownHosts
  private var path: String
  var components: URLComponents {
    var components = URLComponents()
    components.scheme = scheme.rawValue
    components.host = host.rawValue
    components.path = path
    return components
  }
  private let cliendID = "bbbd309bad47cf82681a"
  private let secret = "67da701955a2f2009cd1ba08a2f251a910394f8a"
  private var accessToken: String?
  
  enum ConnectionScheme: String {
    case https = "https"
    case ftp = "ftp"
    case mailto = "mailto"
  }
  
  enum KnownHosts: String {
    case ApiGitHub = "api.github.com"
    case GitHub = "github.com"
    case OpenWeather = "api.openweathermap.org"
  }
  
  let defaultHeaders = [
    "Content-Type" : "application/json",
    "Accept" : "application/vnd.github.v3+json"
  ]
  
  init(scheme: ConnectionScheme, host: KnownHosts, path: String) {
    self.scheme = scheme
    self.host = host
    self.path = path
  }
  
  func initialAuthenticationRequest(scheme: ConnectionScheme? = nil,
                                    host: KnownHosts? = nil,
                                    path: String? = nil
  ) -> URLRequest?  {
    if let scheme = scheme, let host = host, let path = path {
      self.scheme = scheme
      self.host = host
      self.path = path
    }
    
    self.host = .GitHub
    var components = URLComponents()
    components.scheme = self.scheme.rawValue
    components.path = self.path
    components.host = self.host.rawValue
    components.queryItems = [URLQueryItem(name: "client_id", value: cliendID)]
    guard let url = components.url else {return nil}
    let request = URLRequest(url: url)
    return request
  }
  
  func getAuthorizationToken(code: String, completion: @escaping (Data?) -> Void){
    self.scheme = .https
    self.host = .GitHub
    self.path = "/login/oauth/access_token"
    let query: [URLQueryItem] = [URLQueryItem(name: "client_id", value: cliendID), URLQueryItem(name: "client_secret", value: secret), URLQueryItem(name: "code", value: code)]
    var workingComponentsCopy = components
    workingComponentsCopy.queryItems = query
    guard let url = workingComponentsCopy.url else {return}
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.allHTTPHeaderFields = ["Accept" : "application/json"]
    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: request) {(data, response, error) in
      if let error = error {
        print("Error code: \(error.localizedDescription)")
      }
      if let response = response as? HTTPURLResponse {
        print("http status code: \(response.statusCode)")
      }
      if let data = data {
        completion(data)
      }
    }
    task.resume()
  }
  
  func performSimpleSearchRequest (scheme: ConnectionScheme,
                                   host: KnownHosts,
                                   path: String,
                                   parameters: [URLQueryItem],
                                   completion: @escaping (Data?) -> Void) {
    self.scheme = scheme
    self.host = host
    self.path = path
    var workingComponentsCopy = self.components
    workingComponentsCopy.queryItems = parameters
    guard let url = workingComponentsCopy.url else {
      return
    }
    
    let request = URLRequest(url: url)
    let session = URLSession(configuration: .default)
    let dataTask = session.dataTask(with: request) {(data, response, error) in
      if let error = error {
        print("Error code: \(error.localizedDescription)")
      }
      if let response = response as? HTTPURLResponse {
        print("http status code: \(response.statusCode)")
      }
      if let data = data {
        
        completion(data)
      }
    }
    dataTask.resume()
  }
  
  func performSimpleSearchRequest ( parameters: [URLQueryItem], completion: @escaping  (Data?) -> Void) {
    var workingComponentsCopy = components
    workingComponentsCopy.queryItems =  parameters
    
    guard let url = workingComponentsCopy.url else {
      return
    }
    
    let request = URLRequest(url: url)
    let session = URLSession(configuration: .default)
    let dataTask = session.dataTask(with: request) {(data, response, error) in
      if let error = error {
        print("Error code: \(error.localizedDescription)")
      }
      if let response = response as? HTTPURLResponse {
        print("http status code: \(response.statusCode)")
      }
      if let data = data {
        completion(data)
      }
    }
    dataTask.resume()
  }
  
  func getCurrentUser(token: Data, completion: @escaping (CurrentUser?) -> Void) {
    host = .ApiGitHub
    path = "/user"
    let components = self.components
    guard let stringifiedToken = String(data: token, encoding: .utf8) else {return}
    guard let url = components.url else {return}
    var request = URLRequest(url: url)
    request.addValue("token \(stringifiedToken)", forHTTPHeaderField: "Authorization")
    let session = URLSession(configuration: .default)
    let dataTask = session.dataTask(with: request) {data, response, error in
      if let response = response as? HTTPURLResponse {
        print(response.statusCode)
      }
      if let error = error {
        print("Error code: \(error.localizedDescription)")
      }
      if let data = data {
        if let user = try? JSONDecoder().decode(CurrentUser.self, from: data) {
          completion(user)
        } else {
          completion(nil)
        }
      }
    }
    dataTask.resume()
  }
  
}

