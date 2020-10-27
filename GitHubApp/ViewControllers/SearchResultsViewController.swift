//
//  SearchResultsViewController.swift
//  GitHubApp
//
//  Created by Vladimir Banushkin on 22.10.2020.
//

import UIKit
import Kingfisher

class SearchResultsViewController: UIViewController {
  let resultsCount: Int
  let tableView: UITableView
  let results: [Repo]

  
  init(resultsCount: Int, results: [Repo]) {
    self.resultsCount = resultsCount
    tableView = UITableView()
    self.results = results
    super.init(nibName: nil, bundle: nil)
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: "HeaderView")
    tableView.register(RepoCell.self, forCellReuseIdentifier: "RepoCell")
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  
  }
  
  override func viewWillLayoutSubviews() {
    tableView.frame = view.safeAreaLayoutGuide.layoutFrame
    view.addSubview(tableView)
  }
}
