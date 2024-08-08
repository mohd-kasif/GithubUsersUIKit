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
//    lazy var tableView:UITableView={
//        let table=UITableView(frame: view.bounds)
//        table.delegate=self
//        table.dataSource=self
//        table.autoresizingMask=[.flexibleWidth,.flexibleHeight]
//        table.backgroundColor = .systemBackground
//        table.register(UITableViewCell.self, forCellReuseIdentifier: "FavoriteCell")
//        return table
//        
//    }()
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
//        tableView.autoresizingMask=[.flexibleWidth,.flexibleHeight]
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
                    print(self.favoriteList, "favorite")
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
        let cell=tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseId, for: indexPath) as! FavoriteCell
        let favorite=favoriteList[indexPath.row]
        cell.config(with: favorite)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteList.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite=favoriteList[indexPath.row]
        let follow=FollowersVC()
        follow.username=favorite.login
        follow.title=favorite.login
        navigationController?.pushViewController(follow, animated: true)
    }
}
