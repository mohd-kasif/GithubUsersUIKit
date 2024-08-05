//
//  FollowersVC.swift
//  GithubSearch
//
//  Created by Mohd Kashif on 05/08/24.
//

import UIKit

class FollowersVC: UIViewController {
    var username:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden=false
        navigationController?.navigationBar.prefersLargeTitles=true

    }

}
