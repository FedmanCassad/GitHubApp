//
//  SearchReposViewController.swift
//  GitHubApp
//
//  Created by Vladimir Banushkin on 22.10.2020.
//

import UIKit
import Kingfisher

class SearchReposViewController: UIViewController {
  
  private var user: CurrentUser? {
    willSet {
      guard let newValue = newValue else {return}
      avatarImage.kf.setImage(with: URL(string:newValue.avatarURL))
      helloLabel.text = "Hello, \(newValue.login)!"
      helloLabel.sizeToFit()
      helloLabel.center.x = view.center.x
      helloLabel.center.y = 80
    }
  }
  
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
    label.overrideUserInterfaceStyle = .light
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
    field.overrideUserInterfaceStyle = .light
    field.placeholder = "language"
    field.borderStyle = .roundedRect
    field.frame.size = CGSize(width: view.frame.width - 96, height: 25)
    field.center.x = view.center.x
    field.frame.origin.y = repositoryNameSearchField.frame.maxY + 15
    return field
  }()
  
  lazy var sortOption: UISegmentedControl = {
    let control = UISegmentedControl(items: ["Ascended", "Descended"])
    control.selectedSegmentIndex = 0
    control.frame.size = control.intrinsicContentSize
    control.center.x = languageSearchField.center.x
    control.frame.origin.y = languageSearchField.frame.maxY + 15
    return control
  }()
  
  lazy var searchButton: UIButton = {
    let button = UIButton()
    button.setTitle("Start search", for: .normal)
    button.setTitleColor(.systemTeal, for: .normal)
    button.sizeToFit()
    button.center.x = view.center.x
    button.frame.origin.y = sortOption.frame.maxY + 15
    button.addTarget(self, action: #selector(search), for: .touchUpInside)
    return button
  }()
  
  private var sortOrder: SortParam {
    guard sortOption.selectedSegmentIndex == 0 else {
      return .descending
    }
    return .ascending
  }
  
  //MARK: - Lifecycle
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    helloLabel.frame.origin.y += view.safeAreaInsets.top
    view.addSubview(helloLabel)
    view.addSubview(avatarImage)
    view.addSubview(searchRepositoryLabel)
    view.addSubview(repositoryNameSearchField)
    view.addSubview(languageSearchField)
    view.addSubview(sortOption)
    view.addSubview(searchButton)
  }
  
  override func viewDidLoad() {
    view.backgroundColor = .white
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
        networkObject.getCurrentUser(token: token) {[weak self] user in
          guard let self = self, let user = user else {return}
          DispatchQueue.main.async {
            self.user = user
          }
        }
      }
      
    } else {
      if let strigyfiedCode = String(data: tempCode, encoding: .utf8) {
        
        networkObject.getAuthorizationToken(code: strigyfiedCode) {[weak self] data in
          guard let self = self else {return}
          guard let data = data else {return}
          guard let token = Parser.getToken(data) else
          {
            DispatchQueue.main.async {
              self.navigateBackToLoginScreen()
            }
            return}
          let _ = KeyChainService.save(key: "accessToken", data: token)
          networkObject.getCurrentUser(token: token) {user in
            DispatchQueue.main.async {
              self.user = user
            }
          }
        }
      }
    }
  }
  private func navigateBackToLoginScreen() {
    if let navigationController = navigationController {
      let loginVC = LoginViewController()
      navigationController.viewControllers = [loginVC, self]
      navigationController.popViewController(animated: true)
    }
  }
  
  @objc  private func search() {
    guard let searchQ = repositoryNameSearchField.text,
          let languageQ = languageSearchField.text else {return}
    
    let searchObject = NetworkObject(scheme: .https, host: .ApiGitHub, path: "/search/repositories")
    let query = [URLQueryItem(name: "q", value: "\(searchQ)+language:\(languageQ)"),
                 URLQueryItem(name: "per_page", value: "50"),
                 URLQueryItem(name: "sort", value: "stars"),
                 URLQueryItem(name: "order", value: sortOrder.rawValue)]
    
    searchObject.performSimpleSearchRequest(parameters: query
    ) {data in
      var count = 0
      guard let data = data else {return}
      if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]{
        if let jsonCount = json["total_count"] as? Int {
          count = jsonCount
        }
      }
      guard let results = Parser.getRepos(data) else {return}
      DispatchQueue.main.async {
        let resultingVC = SearchResultsViewController(results: results, totalCount: count, usedQueryItems: query)
        self.navigationController?.pushViewController(resultingVC, animated: true)
      }
    }
  }
  
}
