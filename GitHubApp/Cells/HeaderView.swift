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
  label.frame.origin = CGPoint(x: 10, y: 10)
 return label
}()
  
  func configure(resultCount: Int) {
    self.resultCount = resultCount
    contentView.frame = searchResultLabel.bounds
    contentView.frame.size.height += 10
    self.addSubview(searchResultLabel)
  }
  
}
  
