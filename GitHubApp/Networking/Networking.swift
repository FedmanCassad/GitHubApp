//
//  Networking.swift
//  GitHubApp
//
//  Created by Vladimir Banushkin on 22.10.2020.
//

import UIKit
import Kingfisher

class NetworkObject {
  
  enum ConnectionScheme: String {
    case https = "https"
    case ftp = "ftp"
    case mailto = "mailto"
  }
  
  enum KnownHosts: String {
    case GitHub = "api.github.com"
    case OpenWeather = "api.openweathermap.org"
  }
  
  let scheme: ConnectionScheme
  
  let host: KnownHosts
  let path: String
  var components = URLComponents()
  
  let defaultHeaders = [
    "Content-Type" : "application/json",
    "Accept" : "application/vnd.github.v3+json"
  ]
  
  init(scheme: ConnectionScheme, host: KnownHosts, path: String) {
    self.scheme = scheme
    self.host = host
    self.path = path
  }
  
  func performSimpleSearchRequest (scheme: ConnectionScheme,host: KnownHosts, path: String, parameters: [URLQueryItem], completion: @escaping (Data?)-> Void) {
  
    components.scheme = scheme.rawValue
    components.host = host.rawValue
    components.path = path
    components.queryItems = parameters
    guard let url = components.url else {
      return
    }
    let request = URLRequest(url: url)
    let session = URLSession(configuration: .default)
    let group = DispatchGroup()
    DispatchQueue.global(qos: .userInitiated).async {
    group.enter()
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
      group.leave()
    }
    
    dataTask.resume()
    }
    
    group.wait()
   
  }
  
  
  func performSimpleSearchRequest ( parameters: [URLQueryItem],completion: @escaping  (Data?)->Void) {
    components.scheme = scheme.rawValue
    components.host = host.rawValue
    components.path = path
    components.queryItems = parameters
    guard let url = components.url else {
      return
    }
    let request = URLRequest(url: url)
    let session = URLSession(configuration: .default)
    let group = DispatchGroup()
    DispatchQueue.global(qos: .userInitiated).async {
      
    
    group.enter()
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
      group.leave()
    }
    dataTask.resume()
    }
   
    group.wait()
    
  }
}
