//
//  UserInfoHeaderVC.swift
//  GithubSearch
//
//  Created by Mohd Kashif on 07/08/24.
//

import UIKit

class UserInfoHeaderVC: UIViewController {
    let imageView=GFAvatarImageView(frame: .zero)
    let usernameLabel=GFLabel(alignement: .left, fontSize: 34)
    let nameLabel=GFSecondaryLabel(fontSize: 18)
    let locationLabel=GFSecondaryLabel(fontSize: 18)
    let locationImage=UIImageView()
    let bioLabel=GFBodyLabel(alignement: .left)
    var userInfo:UserInfoModel!
    
    init(userInfo: UserInfoModel) {
        super.init(nibName: nil, bundle: nil)
        self.userInfo = userInfo
//        setupUI()
//        configData()
//        configLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configLayout()
        configData()

    }
    
    func setupUI(){
        view.addSubview(imageView)
        view.addSubview(usernameLabel)
        view.addSubview(nameLabel)
        view.addSubview(locationImage)
        view.addSubview(locationLabel)
        view.addSubview(bioLabel)
        
    }
    
    func configLayout(){
        let padding:CGFloat=20
        let textPadding:CGFloat=12
        locationImage.translatesAutoresizingMaskIntoConstraints=false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            imageView.widthAnchor.constraint(equalToConstant: 90),
            imageView.heightAnchor.constraint(equalToConstant: 90),
            
            usernameLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: textPadding),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            nameLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: textPadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            locationImage.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            locationImage.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: textPadding),
            locationImage.widthAnchor.constraint(equalToConstant: 20),
            locationImage.heightAnchor.constraint(equalToConstant: 20),
            
            locationLabel.centerYAnchor.constraint(equalTo: locationImage.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImage.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -padding),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bioLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: textPadding),
            bioLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            bioLabel.heightAnchor.constraint(equalToConstant: 60)
            
        ])

    }
    func configData(){
        imageView.downloadImages(url: userInfo.avatar_url)
        usernameLabel.text=userInfo.login
        nameLabel.text=userInfo.name ?? ""
        locationLabel.text=userInfo.location ?? "NoWhere"
        bioLabel.text=userInfo.bio ?? "No Bio Available"
        bioLabel.numberOfLines=3
        locationImage.image=UIImage(systemName: SFSymbol.location)
        locationImage.tintColor = .secondaryLabel
        
    }
}
