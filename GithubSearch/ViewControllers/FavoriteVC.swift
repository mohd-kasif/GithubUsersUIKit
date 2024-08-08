//
//  FavoriteVC.swift
//  GithubSearch
//
//  Created by Mohd Kashif on 05/08/24.
//

import UIKit

class FavoriteVC: UIViewController {
    var favoriteList:[FolloworsModel]=[]
    let imageView=GFAvatarImageView(frame: .zero)
    let tableView=UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title="Favorites"
        navigationController?.navigationBar.prefersLargeTitles=true
        setupUI()
        retriveFavorite()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        retriveFavorite()
    }
    
    func setupUI(){
        tableView.frame=view.bounds
        tableView.delegate=self
        tableView.dataSource=self
        tableView.rowHeight=80
        tableView.backgroundColor = .systemBackground
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseId)
        view.addSubview(tableView)
    }
    func retriveFavorite(){
        PersistanceManager.retriveFavorite { result in
            switch result {
            case .success(let favorite):
                DispatchQueue.main.async{
                    self.favoriteList=favorite
                    self.tableView.reloadData()
                }
            case .failure(let failure):
                print(failure, "unable to retrive")
            }
        }
    }
    

}

extension FavoriteVC:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell=tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseId, for: indexPath) as? FavoriteCell else {fatalError("")}
        let favorite=favoriteList[indexPath.row]
        cell.config(with: favorite)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteList.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite=favoriteList[indexPath.row]
        let follow=FollowersVC(loginId: favorite.login)
        navigationController?.pushViewController(follow, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if (editingStyle == UITableViewCell.EditingStyle.delete) {
             let row=favoriteList[indexPath.row]
             favoriteList.remove(at: indexPath.row)
             tableView.deleteRows(at: [indexPath], with: .left)
             PersistanceManager.updateWith(favorite: row, persistenceType: .delete) {[weak self] error in
                 guard let self=self else {return}
                 if error != nil{
                     self.presentAlertMainThread(title: "Unable to remove", message: error!.rawValue, buttonTitle: "Ok")
                 }
             }
        }
    }
    
}
