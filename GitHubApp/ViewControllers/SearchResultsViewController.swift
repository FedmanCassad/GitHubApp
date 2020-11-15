//
//  SearchResultsViewController.swift
//  GitHubApp
//
//  Created by Vladimir Banushkin on 22.10.2020.
//

import UIKit
import Kingfisher

class SearchResultsViewController: UIViewController {
  let tableView: UITableView
  var results: [Repo]
  let totalCount: Int
  var heightsForRows: [CGFloat] = [CGFloat]()
  var usedQueryItems: [URLQueryItem]?
  var currentPage: Int = 1
  var minIndexPathItem: Int = 50
  
  init(results: [Repo], totalCount: Int, usedQueryItems: [URLQueryItem]?) {
    tableView = UITableView()
    self.results = results
    self.totalCount = totalCount
    self.usedQueryItems = usedQueryItems
    super.init(nibName: nil, bundle: nil)
    tableView.delegate = self
    tableView.dataSource = self
    tableView.estimatedRowHeight = UITableView.automaticDimension
    tableView.rowHeight = UITableView.automaticDimension
    tableView.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: "HeaderView")
    tableView.register(RepoCell.self, forCellReuseIdentifier: "RepoCell")
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewWillLayoutSubviews() {
    tableView.frame = view.safeAreaLayoutGuide.layoutFrame
    view.addSubview(tableView)
  }
  
}
