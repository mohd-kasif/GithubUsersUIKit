//
//  FavoriteCell.swift
//  GithubSearch
//
//  Created by Mohd Kashif on 08/08/24.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    static let reuseId="FavoriteCell"
    var avatarImage=GFAvatarImageView(frame: .zero)
    let usernameLabel=GFLabel(alignement: .left, fontSize: 26)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        addSubview(avatarImage)
        addSubview(usernameLabel)
        
        accessoryType = .disclosureIndicator
        let padding:CGFloat=12
        
        NSLayoutConstraint.activate([
            avatarImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarImage.heightAnchor.constraint(equalToConstant: 60),
            avatarImage.widthAnchor.constraint(equalToConstant: 60),
            
            usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 24),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func config(with userinfo:FolloworsModel){
        usernameLabel.text=userinfo.login
        avatarImage.downloadImages(url: userinfo.avatar_url)
    }
    
}
