//
//  HeaderCell.swift
//  GitHubApp
//
//  Created by Vladimir Banushkin on 23.10.2020.
//

import UIKit
class HeaderView: UITableViewHeaderFooterView {
  var resultCount: Int!
private lazy var searchResultLabel: UILabel = {
 let label = UILabel()
  label.frame.size = CGSize(width: UIScreen.main.bounds.width, height: 15)
  label.text = "Repositories found: \((resultCount) ?? 0)"
 return label
}()
  
  init () {
    super.init(reuseIdentifier: "HeaderView")
  }
  
  func configure(resultCount: Int) {
    self.resultCount = resultCount
    contentView.frame = searchResultLabel.bounds
    self.addSubview(searchResultLabel)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
  
