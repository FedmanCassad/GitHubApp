//
//  SearchReposViewController.swift
//  GitHubApp
//
//  Created by Vladimir Banushkin on 22.10.2020.
//

import UIKit
import Kingfisher

class SearchReposViewController: UIViewController {
  
  lazy var helloLabel: UILabel = {
    let label = UILabel()
    label.text = "Hello"
    label.sizeToFit()
    label.center.x = view.center.x
    label.center.y = 80
    return label
  }()
  
  lazy var avatarImage: UIImageView = {
    let imageView = UIImageView()
    imageView.frame.size = CGSize(width: 150, height: 150)
    imageView.center.x = helloLabel.center.x
    imageView.frame.origin.y = helloLabel.frame.maxY + 25
    imageView.makeRounded()
    
    imageView.image = UIImage(named: "avatar")
    return imageView
  }()
  
  lazy var searchRepositoryLabel: UILabel = {
    let label = UILabel()
    label.text = "Search repository"
    label.sizeToFit()
    label.center.x = helloLabel.center.x
    label.frame.origin.y = avatarImage.frame.maxY + 45
    return label
  }()
  
  lazy var repositoryNameSearchField: UITextField = {
    let field = UITextField()
    field.placeholder = "repository name"
    field.borderStyle = .roundedRect
    field.frame.size = CGSize(width: view.frame.width - 96, height: 25)
    field.center.x = view.center.x
    field.frame.origin.y = searchRepositoryLabel.frame.maxY + 15
    return field
  }()
  
  lazy var languageSearchField: UITextField = {
    let field = UITextField()
    field.placeholder = "language"
    field.borderStyle = .roundedRect
    field.frame.size = CGSize(width: view.frame.width - 96, height: 25)
    field.center.x = view.center.x
    field.frame.origin.y = repositoryNameSearchField.frame.maxY + 15
    return field
  }()
  
  lazy var searchButton: UIButton = {
    let button = UIButton()
    button.setTitle("Start search", for: .normal)
    button.setTitleColor(.systemTeal, for: .normal)
    button.sizeToFit()
    button.center.x = view.center.x
    button.frame.origin.y = languageSearchField.frame.maxY + 15
    button.addTarget(self, action: #selector(search), for: .touchUpInside)
    return button
  }()
  
  //MARK:- URLSession constants
  
  let baseURL = "api.github.com"
  //MARK: - Lifecycle
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    helloLabel.frame.origin.y += view.safeAreaInsets.top
    view.addSubview(helloLabel)
    view.addSubview(avatarImage)
    view.addSubview(searchRepositoryLabel)
    view.addSubview(repositoryNameSearchField)
    view.addSubview(languageSearchField)
    view.addSubview(searchButton)
  }
  
  override func viewDidLoad() {
    view.backgroundColor = .white
  }
  
 @objc  private func search() {
  
  guard let searchQ = repositoryNameSearchField.text,
        let languageQ = languageSearchField.text else {return}
  
    let searchObject = NetworkObject(scheme: .https, host: .GitHub, path: "/search/repositories")
  searchObject.performSimpleSearchRequest(parameters: [URLQueryItem(name: "q", value: "\(searchQ)+language:\(languageQ)")]) {data in
    guard let data = data else {return}
    let stringifiedResult = String(data: data, encoding: .utf8)
  
    print(stringifiedResult!)
    
    
  }
  
}
  
}
