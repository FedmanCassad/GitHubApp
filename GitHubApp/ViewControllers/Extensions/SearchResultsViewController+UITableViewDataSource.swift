//
//  SearchResultsViewController+UITableViewDataSource.swift
//  GitHubApp
//
//  Created by Vladimir Banushkin on 24.10.2020.
//

import UIKit

extension SearchResultsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return results.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell", for: indexPath) as! RepoCell
    cell.configure(repo: results[indexPath.item])
    return cell
  }
  
  
  
}
