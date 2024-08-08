//
//  GFRepoItemVC.swift
//  GithubSearch
//
//  Created by Mohd Kashif on 07/08/24.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {
    weak var delegate:UserInfoVCDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        configData()
    }
    
    func configData(){
        itemInfoOne.config(itemInfoType: .repos, count: userInfo.public_repos)
        itemInfoTwo.config(itemInfoType: .gist, count: userInfo.public_gists)
        actionButton.configButton(background: .systemPurple, title: "Github Profile", image: SFSymbol.person1)
        actionButton.addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }
    @objc func didTap(){
        delegate?.tapGithubProfileBtn()
    }
}
