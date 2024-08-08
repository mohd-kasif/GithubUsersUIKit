//
//  GFItemFollowVC.swift
//  GithubSearch
//
//  Created by Mohd Kashif on 07/08/24.
//

import Foundation

class GFItemFollowVC:GFItemInfoVC{
    weak var delegate:UserInfoVCDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        configData()
    }
    
    func configData(){
        itemInfoOne.config(itemInfoType: .follows, count: userInfo.followers)
        itemInfoTwo.config(itemInfoType: .following, count: userInfo.following)
        actionButton.configButton(background: .systemGreen, title: "Get Followers", image: SFSymbol.person3)
        actionButton.addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }
    @objc func didTap(){
        delegate?.tapGetFollowersBtn()
    }
}
