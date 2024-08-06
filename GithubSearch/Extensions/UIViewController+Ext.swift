//
//  UIViewController+Ext.swift
//  GithubSearch
//
//  Created by Mohd Kashif on 06/08/24.
//

import UIKit

extension UIViewController{
    func presentAlertMainThread(title:String, message:String, buttonTitle:String){
        DispatchQueue.main.async {
            let alertVC=CustomAlert(alertTitle: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
