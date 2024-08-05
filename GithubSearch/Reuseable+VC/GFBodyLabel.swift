//
//  GFBodyLabel.swift
//  GithubSearch
//
//  Created by Mohd Kashif on 06/08/24.
//

import UIKit

class GFBodyLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(alignement:NSTextAlignment){
        super.init(frame: .zero)
        self.textAlignment=alignement
        setupUI()
    }
    
    private func setupUI(){
        textColor = .secondaryLabel
        font=UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth=true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints=false
    }

}
