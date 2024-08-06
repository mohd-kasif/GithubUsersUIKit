//
//  GFCell.swift
//  GithubSearch
//
//  Created by Mohd Kashif on 06/08/24.
//

import UIKit

class GFCell: UICollectionViewCell {
    static let reuseId="FollowCell"
    var avatarImage=GFAvatarImageView(frame: .zero)
    let usernameLabel=GFLabel(alignement: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        addSubview(avatarImage)
        addSubview(usernameLabel)
        let padding:CGFloat=8
        
        //constraint
        
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo:topAnchor, constant: padding),
            avatarImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            avatarImage.heightAnchor.constraint(equalTo: avatarImage.widthAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func config(follower:FolloworsModel){
        usernameLabel.text=follower.login
        avatarImage.downloadImages(url: follower.avatar_url)
        
    }
}
