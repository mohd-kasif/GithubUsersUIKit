//
//  UIViewController+Ext.swift
//  GithubSearch
//
//  Created by Mohd Kashif on 06/08/24.
//

import UIKit
fileprivate var container:UIView!
extension UIViewController{
    func presentAlertMainThread(title:String, message:String, buttonTitle:String){
        DispatchQueue.main.async {
            let alertVC=CustomAlert(alertTitle: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func showLoadingView(){
        container=UIView(frame: view.bounds)
        view.addSubview(container)
        container.backgroundColor = .systemBackground
        container.alpha=0
        UIView.animate(withDuration: 0.25, animations: {
            container.alpha=0.8
        })
        let activityIndicator=UIActivityIndicatorView(style: .large)
        container.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints=false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView(){
        DispatchQueue.main.async {
            container.removeFromSuperview()
            container=nil
        }
    }
    
    func showEmptyStateVC(message:String, view:UIView){
        let emptyView=GFEmptyVC(text: message)
        emptyView.frame=view.bounds
        view.addSubview(emptyView)
        
    }
}
