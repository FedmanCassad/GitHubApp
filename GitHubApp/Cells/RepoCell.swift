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
    return label
  }()
  
  private lazy var repoDescriptionLabel: UILabel = {
    let label = UILabel()
    
    return label
  }()
  
  private lazy var nicknameLabel: UILabel = {
    let label = UILabel()
    return label
  }()
  
  private lazy var avatarImage: UIImageView = {
    let imageView = UIImageView()
    return imageView
  }()
  
  func configureLayout() {
    repositoryName.frame.size = CGSize(width: UIScreen.main.bounds.width * 0.45, height: 20)
    repositoryName.frame.origin = CGPoint(x: 25, y: 0)
    repositoryName.numberOfLines = 1
    repositoryName.font = UIFont.boldSystemFont(ofSize: 17)
    
    repoDescriptionLabel.preferredMaxLayoutWidth = repositoryName.frame.width
    repoDescriptionLabel.numberOfLines = 5
    repoDescriptionLabel.sizeToFit()
    repoDescriptionLabel.frame.size = CGSize(width: repositoryName.frame.width,
                                             height: repoDescriptionLabel.intrinsicContentSize.height)
    repoDescriptionLabel.frame.origin = CGPoint(x: repositoryName.frame.origin.x,
                                                y: repositoryName.frame.maxY + 5)
    repoDescriptionLabel.textAlignment = .left
    
    nicknameLabel.frame.size = CGSize(width: contentView.frame.width - repositoryName.frame.width - 32, height: 20)
    nicknameLabel.frame.origin = CGPoint(x: repositoryName.frame.maxX + 30, y: repositoryName.frame.origin.y)
    nicknameLabel.numberOfLines = 1
    nicknameLabel.textAlignment = .center
    
    avatarImage.frame.size = CGSize(width: 50, height: 50)
    avatarImage.center.x = nicknameLabel.center.x
    avatarImage.frame.origin.y = nicknameLabel.frame.maxY + 5
    avatarImage.clipsToBounds = true
    avatarImage.makeRounded()

    contentView.addSubview(repositoryName)
    contentView.addSubview(repoDescriptionLabel)
    contentView.addSubview(nicknameLabel)
    contentView.addSubview(avatarImage)
  }
  
  func configure(repo: Repo) {
    self.repo = repo
    repositoryName.text = repo.repoName
    repoDescriptionLabel.text = repo.repoDescription
    nicknameLabel.text = repo.owner.login
    contentView.frame.size.width = UIScreen.main.bounds.width
    configureLayout()
    self.avatarImage.kf.setImage(with: URL(string: repo.owner.avatarURL.absoluteString))
    if repoDescriptionLabel.frame.maxY >= avatarImage.frame.maxY {
      contentView.bounds.size.height = repoDescriptionLabel.frame.maxY + 5}
    else {
      contentView.bounds.size.height = avatarImage.frame.maxY + 5
    }
  }
  
}
