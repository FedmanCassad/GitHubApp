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
  }
  
 @objc  private func search() {
  guard let searchQ = repositoryNameSearchField.text,
        let languageQ = languageSearchField.text else {return}
  
    let searchObject = NetworkObject(scheme: .https, host: .GitHub, path: "/search/repositories")
  searchObject.performSimpleSearchRequest(parameters:
                                            [URLQueryItem(name: "q", value: "\(searchQ)+language:\(languageQ)"),
                                             URLQueryItem(name: "per_page", value: "50"),
                                             URLQueryItem(name: "sort", value: "stars"),
                                             URLQueryItem(name: "order", value: sortOrder.rawValue)]) {data in
    var count = 0
    guard let data = data else {return}
    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]{
    if let jsonCount = json["total_count"] as? Int {
      count = jsonCount
    }
    }
    let parser = RepoParser(data: data)
    guard let results = parser.getRepos() else {return}
    DispatchQueue.main.async {
      let resultingVC = SearchResultsViewController(results: results, totalCount: count, usedQueryItems: searchObject.components.queryItems )
    self.navigationController?.pushViewController(resultingVC, animated: true)
  }
  }
}
  
}
