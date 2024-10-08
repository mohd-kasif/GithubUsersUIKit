//
//  GithubTextField.swift
//  GithubSearch
//
//  Created by Mohd Kashif on 05/08/24.
//

import UIKit

class GithubTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        translatesAutoresizingMaskIntoConstraints=false
        layer.cornerRadius=10
        layer.borderWidth=2
        layer.borderColor=UIColor.systemGray4.cgColor
        textColor = .label
        tintColor = .label
        textAlignment = .center
        font=UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize=12
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        placeholder="Enter username"
        clearButtonMode = .whileEditing
        returnKeyType = .go
        
    }
    
}
