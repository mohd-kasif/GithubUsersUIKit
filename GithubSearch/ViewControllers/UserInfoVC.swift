//
//  UserInfoVC.swift
//  GithubSearch
//
//  Created by Mohd Kashif on 07/08/24.
//

import UIKit
import SafariServices

protocol UserInfoVCDelegate:AnyObject{
    func tapGithubProfileBtn()
    func tapGetFollowersBtn()
}

class UserInfoVC: UIViewController {
    var username:String!
    let headerView=UIView()
    let itemOneView=UIView()
    let itemTwoView=UIView()
    let dateLabel=GFBodyLabel(alignement: .center)
    weak var delegate:FollowersVCDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        navigationItem.rightBarButtonItem=UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissSheet))
        navigationController?.navigationBar.backgroundColor = .systemGray4
        NetworkLayer.shared.getUserInfo(loginId: username) {[weak self] result in
            guard let self=self else {return}
            switch result {
            case .success(let userinfo):
                DispatchQueue.main.async {
                    self.configUIItems(userinfo:userinfo)
                }
            case .failure(let error):
                self.presentAlertMainThread(title: "Something went wrong 😔.", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configUIItems(userinfo:UserInfoModel){
        
        let itemRepoVc=GFRepoItemVC(userInfo: userinfo)
        let itemFollowersVC=GFItemFollowVC(userInfo: userinfo)
        itemRepoVc.delegate=self
        itemFollowersVC.delegate=self
        
        self.add(childVC: UserInfoHeaderVC(userInfo: userinfo), container: self.headerView)
        self.add(childVC: itemRepoVc, container: self.itemOneView)
        self.add(childVC: itemFollowersVC, container: self.itemTwoView)
        self.dateLabel.text="Since \(userinfo.created_at.convertToDisplayDate())"
    }
    
    @objc func dismissSheet(){
        dismiss(animated: true)
    }
    
    func setupUI(){
        view.addSubview(headerView)
        view.addSubview(itemOneView)
        view.addSubview(itemTwoView)
        view.addSubview(dateLabel)
        headerView.translatesAutoresizingMaskIntoConstraints=false
        itemOneView.translatesAutoresizingMaskIntoConstraints=false
        itemTwoView.translatesAutoresizingMaskIntoConstraints=false
       
        //constraint
        let padding:CGFloat=20
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemOneView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemOneView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemOneView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemOneView.heightAnchor.constraint(equalToConstant: 140),
            
            itemTwoView.topAnchor.constraint(equalTo: itemOneView.bottomAnchor, constant: padding),
            itemTwoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemTwoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemTwoView.heightAnchor.constraint(equalToConstant: 140),
            
            dateLabel.topAnchor.constraint(equalTo: itemTwoView.bottomAnchor, constant: padding),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
            
        ])
    }
    
    func add(childVC:UIViewController , container:UIView){
        addChild(childVC)
        container.addSubview(childVC.view)
        childVC.view.frame=container.bounds
        childVC.didMove(toParent: self)
    }

}

extension UserInfoVC:UserInfoVCDelegate{
    func tapGithubProfileBtn() {
        guard let username=username,let url=URL(string: APIEndpoints.htmlUrl+"\(username)") else {return}
        let safariVC=SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
    
    func tapGetFollowersBtn() {
        delegate?.updateNewFollowers(with: username)
        dismiss(animated: true)
    }

}
