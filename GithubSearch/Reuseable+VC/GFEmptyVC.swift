//
//  GFEmptyVC.swift
//  GithubSearch
//
//  Created by Mohd Kashif on 07/08/24.
//

import UIKit

class GFEmptyVC: UIView {
    let label=GFLabel(alignement: .center, fontSize: 26)
    let imageView=UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(text:String){
        super.init(frame: .zero)
        label.text=text
        setupUI()
    }
    
    private func setupUI(){
        addSubview(label)
        addSubview(imageView)
        
        label.numberOfLines=3
        label.textColor = .secondaryLabel
        
        imageView.image=UIImage(named: "empty-logo")
        imageView.translatesAutoresizingMaskIntoConstraints=false
        
        //constraint
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            label.heightAnchor.constraint(equalToConstant: 200),
            
            /// make the widtn of image 1.3 times the width of screen
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            imageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 40)
            
        ])
    }
    
}
