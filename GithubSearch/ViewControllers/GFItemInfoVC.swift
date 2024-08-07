//
//  GFItemInfoVC.swift
//  GithubSearch
//
//  Created by Mohd Kashif on 07/08/24.
//

import UIKit

class GFItemInfoVC: UIViewController {
    let stackView=UIStackView()
    let itemInfoOne=GFItemInfoView()
    let itemInfoTwo=GFItemInfoView()
    let actionButton=GithubButton()
    
    var userInfo:UserInfoModel!
    
    init(userInfo: UserInfoModel) {
        super.init(nibName: nil, bundle: nil)
        self.userInfo = userInfo
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        view.layer.cornerRadius=18
        view.backgroundColor = .secondarySystemBackground
        
        view.addSubview(stackView)
        view.addSubview(actionButton)
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(itemInfoOne)
        stackView.addArrangedSubview(itemInfoTwo)
        
        stackView.translatesAutoresizingMaskIntoConstraints=false
        
        let padding:CGFloat=20
        
        //constraint
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
//            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

}
