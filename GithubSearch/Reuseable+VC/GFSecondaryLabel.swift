//
//  GFSecondaryLabel.swift
//  GithubSearch
//
//  Created by Mohd Kashif on 07/08/24.
//

import UIKit

class GFSecondaryLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(fontSize:CGFloat){
        super.init(frame: .zero)
        font=UIFont.systemFont(ofSize: fontSize, weight: .medium)
        setupUI()
    }
    
    private func setupUI(){
        textColor = .secondaryLabel
        minimumScaleFactor = 0.90
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints=false
    }

}
