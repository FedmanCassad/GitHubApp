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
  var components = URLComponents()
  private let cliendID = "bbbd309bad47cf82681a"
  private let secret = "67da701955a2f2009cd1ba08a2f251a910394f8a"
  
  //  private var usersScheme: ConnectionScheme {
  //    return scheme
  //  }
  //
  //  private var usersHost: KnownHosts {
  //    return host
  //  }
  //
  //  private var usersPath: String {
  //    return path
  //  }
  //
 
  
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
  
  func AuthenticationRequest(scheme: ConnectionScheme? = nil ,host: KnownHosts? = nil, path: String? = nil) -> URLRequest?  {
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
    print(url)
    let request = URLRequest(url: url)
    return request
  }
  
  func performSimpleSearchRequest (scheme: ConnectionScheme,host: KnownHosts, path: String, parameters: [URLQueryItem], completion: @escaping (Data?) -> Void) {
    
    components.scheme = scheme.rawValue
    components.host = host.rawValue
    components.path = path
    components.queryItems = parameters
    guard let url = components.url else {
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
  
  func performSimpleSearchRequest ( parameters: [URLQueryItem],completion: @escaping  (Data?) -> Void) {
    components.scheme = scheme.rawValue
    components.host = host.rawValue
    components.path = path
    components.queryItems = parameters
    guard let url = components.url else {
      return
    }
    
    let request = URLRequest(url: url)
    let session = URLSession(configuration: .default)
    print(url)
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
  
}

