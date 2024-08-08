//
//  GithubButton.swift
//  GithubSearch
//
//  Created by Mohd Kashif on 05/08/24.
//

import UIKit

class GithubButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //custom code here
        setupButtonUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    init(title:String, color:UIColor){
//        super.init(frame: .zero)
//        self.backgroundColor=color
//        self.setTitle(title, for: .normal)
//        setupButtonUI()
//        configButton(background: color, title: title)
//    }
    
    convenience init(title:String, color:UIColor,image:String){
        self.init(frame: .zero)
        configButton(background: color, title: title,image:image)
    }
    
    private func setupButtonUI(){
//        layer.cornerRadius=10
        configuration = .tinted()
        configuration?.cornerStyle = .medium
//        setTitleColor(.white, for: .normal)
//        titleLabel?.font=UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints=false
    }
    
    func configButton(background:UIColor, title:String, image:String){
//        self.backgroundColor=background
//        self.setTitle(title, for: .normal)
        configuration?.baseBackgroundColor = background
        configuration?.baseForegroundColor = background
        configuration?.title=title
        configuration?.image=UIImage(systemName: image)
        configuration?.imagePadding=6
        configuration?.imagePlacement = .leading
    }
}
