//
//  SearchResultsViewController+UiTableViewDelegate.swift
//  GitHubApp
//
//  Created by Vladimir Banushkin on 24.10.2020.
//

import UIKit

extension SearchResultsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as! HeaderView
    header.configure(resultCount: results.count)
    return header
  }
}
