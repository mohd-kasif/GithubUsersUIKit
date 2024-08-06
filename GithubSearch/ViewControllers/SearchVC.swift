//
//  SearchVC.swift
//  GithubSearch
//
//  Created by Mohd Kashif on 05/08/24.
//

import UIKit

class SearchVC: UIViewController {
    let imageView=UIImageView()
    let textField=GithubTextField()
    let button=GithubButton(title: "Get Followers", color: UIColor.systemGreen)
    
    var istextfieldEmpty:Bool{
        return !textField.text!.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        dismissKeyboard()
    }
    @objc func follow(){
        guard istextfieldEmpty else {
            presentAlertMainThread(title: "Empty Username", message: "Please enter a username. We need to check who you are looking for 😔", buttonTitle: "Ok") //  to enter emoji press (command+control+space)
            return
        }
        let followList=FollowersVC()
        followList.username=textField.text
        followList.title=textField.text
        navigationController?.pushViewController(followList, animated: true)
    }
    private func setupUI(){
        imageView.translatesAutoresizingMaskIntoConstraints=false
        imageView.image=UIImage(named: "gf-folo")!
        textField.delegate=self
        button.addTarget(self, action: #selector(follow), for: .touchUpInside)
        view.addSubview(imageView)
        view.addSubview(textField)
        view.addSubview(button)
        
        //constraunt
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            
            textField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            textField.heightAnchor.constraint(equalToConstant: 50),
            
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            button.heightAnchor.constraint(equalToConstant: 50),
            
            
        ])
    }
    
    private func dismissKeyboard(){
        let tap=UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

}

extension SearchVC:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        follow()
        return true
    }
}
