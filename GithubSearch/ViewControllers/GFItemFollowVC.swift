//
//  GFItemFollowVC.swift
//  GithubSearch
//
//  Created by Mohd Kashif on 07/08/24.
//

import Foundation

class GFItemFollowVC:GFItemInfoVC{
    override func viewDidLoad() {
        super.viewDidLoad()
        configData()
    }
    
    func configData(){
        itemInfoOne.config(itemInfoType: .follows, count: userInfo.followers)
        itemInfoTwo.config(itemInfoType: .following, count: userInfo.following)
        actionButton.configButton(background: .systemGreen, title: "Get Followers")
    }
}
