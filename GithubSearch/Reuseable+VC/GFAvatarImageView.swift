//
//  GFAvatarImageView.swift
//  GithubSearch
//
//  Created by Mohd Kashif on 06/08/24.
//

import UIKit

class GFAvatarImageView: UIImageView {
    let cache=NetworkLayer.shared.cache
    private let placeholderImage=UIImage(named: "placeholder-image")!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI(){
        layer.cornerRadius=10
        clipsToBounds=true
        image=placeholderImage
        translatesAutoresizingMaskIntoConstraints=false
    }
    
    func downloadImages(url:String){
        if let image=cache.object(forKey: url as NSString){
            self.image=image
            return
        }
        guard let urlString=URL(string: url) else {
            return
        }
        let dataTask=URLSession.shared.dataTask(with: urlString){[weak self] data, response, error in
            guard let self=self else {return}
            if error != nil{
                return
            }
            guard let data=data, let response=response as? HTTPURLResponse, response.statusCode==200 else {return}
            guard let image=UIImage(data: data) else {return}
            self.cache.setObject(image, forKey: url as NSString)
            DispatchQueue.main.async {
                self.image=image
                
            }
        }
        dataTask.resume()
        
    }
}
