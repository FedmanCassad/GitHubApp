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
    header.configure(resultCount: totalCount)
    return header
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    1
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let url = URL(string:results[indexPath.row].htmlURL) else {return}
    let repoWebView = CommonWebViewScontroller(url)
    navigationController?.pushViewController(repoWebView, animated: true)
  }
  
}
