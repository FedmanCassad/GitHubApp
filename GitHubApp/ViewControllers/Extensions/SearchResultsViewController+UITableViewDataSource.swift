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
    cell.configure(repo: results[indexPath.row])
    
    // Сколько не пытался динамически менять высоту ячейки, например через метод делегата - все равно в каких-то местах вылезала ерунда какая-то. Вот так идеально работает
    tableView.rowHeight = cell.contentView.frame.height
    return cell
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
    guard totalCount > 50, results.count < totalCount else {return}
    guard let usedQueryItems = usedQueryItems else {return}
    if indexPath.row == results.count - 5 {
      let searchObject = NetworkObject(scheme: .https, host: .GitHub, path: "/search/repositories")
      currentPage += 1
      let pageQueryItem = URLQueryItem(name: "page", value: "\(currentPage)")
      var fetchingQuery = usedQueryItems
      fetchingQuery.append(pageQueryItem)
      searchObject.performSimpleSearchRequest(parameters: fetchingQuery) {[weak self] data in
        guard let self = self,
              let data = data else {return}
        let parser = RepoParser(data: data)
        guard let fetchingResult = parser.getRepos() else {return}
        self.results.append(contentsOf: fetchingResult)
        DispatchQueue.main.async {
          tableView.reloadData()
        }
      }
    }
  }
  
}
