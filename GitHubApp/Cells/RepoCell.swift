//
//  RepoCell.swift
//  GitHubApp
//
//  Created by Vladimir Banushkin on 23.10.2020.
//

import UIKit

class RepoCell: UITableViewCell {
  
  var repo: Repo!
  
  private lazy var repositoryName: UILabel = {
    let label = UILabel()
    label.text = repo.repoName
    label.frame.size = CGSize(width: UIScreen.main.bounds.width * 0.45, height: 20)
    label.frame.origin = CGPoint(x: 25, y: 0)
    label.numberOfLines = 1
    label.font = UIFont.boldSystemFont(ofSize: 17)
    return label
  }()
  
  private lazy var repoDescriptionLabel: UILabel = {
    let label = UILabel()
    if let description = repo.repoDescription {
      label.text = description
    }
    else {
      label.text = ""
    }
    label.frame.size = CGSize(width: repositoryName.frame.width,
                              height: repositoryName.frame.height)
    label.numberOfLines = 5
    label.preferredMaxLayoutWidth = repositoryName.frame.width
    label.sizeToFit()
    label.frame.origin = CGPoint(x: 0,
                                 y: repositoryName.frame.maxY + 5)
    return label
  }()
  
  private lazy var nicknameLabel: UILabel = {
    let label = UILabel()
    label.text = repo.authorName
    label.frame.size = CGSize(width: contentView.frame.width - repositoryName.frame.width - 32, height: 10)
    label.frame.origin = CGPoint(x: repositoryName.frame.maxX + 30, y: repositoryName.frame.origin.y)
    label.numberOfLines = 1
    return label
  }()
  
  private lazy var avatarImage: UIImageView = {
    let imageView = UIImageView()
    imageView.frame.size = CGSize(width: 50, height: 50)
    imageView.center.x = nicknameLabel.center.x
    imageView.center.y += nicknameLabel.frame.maxY + 30
    imageView.image = repo.avatarImage
    imageView.makeRounded()
    return imageView
  }()
  
  
  
  init() {
    
    super.init(style: .default, reuseIdentifier: "RepoCell")
  }
  
 func configure(repo: Repo) {
    self.repo = repo
    contentView.frame.size.width = UIScreen.main.bounds.width
    contentView.addSubview(repositoryName)
    contentView.addSubview(repoDescriptionLabel)
    contentView.addSubview(nicknameLabel)
    contentView.addSubview(avatarImage)
    contentView.frame.size.height = repoDescriptionLabel.frame.maxY
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
