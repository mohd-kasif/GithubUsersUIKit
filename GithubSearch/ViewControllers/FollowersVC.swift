//
//  FollowersVC.swift
//  GithubSearch
//
//  Created by Mohd Kashif on 05/08/24.
//

import UIKit
enum Section{
    case main
}
protocol FollowersVCDelegate:AnyObject{
    func updateNewFollowers(with username:String)
}

class FollowersVC: UIViewController {
    var username:String!
    private var followers:[FolloworsModel]=[]
    var filterFollowers:[FolloworsModel]=[]
    var dataSource:UICollectionViewDiffableDataSource<Section, FolloworsModel>!
    var collectionView:UICollectionView!
    var page:Int=1
    var hasMoreFollowers:Bool=true
    var isSearching:Bool=false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden=false
        navigationController?.navigationBar.prefersLargeTitles=true
        navigationItem.rightBarButtonItem=UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToFavorite))
        

        configCollectionView()
        getFollowers(username: username, page: page)
        configDataSource()
        configSearchController()

    }
    @objc func addToFavorite(){
        self.showLoadingView()
        NetworkLayer.shared.getUserInfo(loginId: username) {[weak self] result in
            guard let self=self else {return}
            self.dismissLoadingView()
            switch result {
            case .success(let user):
                let favorite=FolloworsModel(login: user.login, avatar_url: user.avatar_url)
                PersistanceManager.updateWith(favorite: favorite, persistenceType: .add) {[weak self]error in
                    guard let self=self else {return}
                    if error==nil{
                        self.presentAlertMainThread(title: "Success", message: "You have successgully added this user to your favorite list 🥳", buttonTitle: "Ok")
                    } else {
                        self.presentAlertMainThread(title: "Someting went wrong", message: "\(error!.rawValue)🥳", buttonTitle: "Ok")
                    }
                }
            case .failure(let error):
                self.presentAlertMainThread(title: "Someting went wrong", message: "\(error.rawValue)🥳", buttonTitle: "Ok")
            }
        }
        
    }
    
    func configCollectionView(){
        collectionView=UICollectionView(frame: view.bounds, collectionViewLayout: threeColumnLayOut())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(GFCell.self, forCellWithReuseIdentifier: GFCell.reuseId)
//        collectionView.dataSource=self
        collectionView.delegate=self
    }
    
    func threeColumnLayOut()->UICollectionViewLayout{
        let width=view.bounds.width
        let padding:CGFloat=12
        let minimumItemSpacing:CGFloat=10
        let availableWidth=width-(padding*2)-(minimumItemSpacing*2)
        
        let itemWidth=availableWidth/3
        
        let flowLayout=UICollectionViewFlowLayout()
        flowLayout.sectionInset=UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize=CGSize(width: itemWidth, height: itemWidth+40)
        return flowLayout
    }
    
    func getFollowers(username:String, page:Int){
        showLoadingView()
        NetworkLayer.shared.getFollowers(username: username, page: page) {[weak self] result in
            guard let self=self else {return}
            dismissLoadingView()
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    if success.count<APIEndpoints.perPage {
                        self.hasMoreFollowers=false
                    }
                    self.followers.append(contentsOf: success)
                    if self.followers.isEmpty{
                        self.showEmptyStateVC(message: "This user doesn't have any followers. Go and follow them 😔.", view: self.view)
                        return
                    }
//                    self.collectionView.reloadData()
                    self.updateData(data: self.followers)
//                    print(self.followers,"followers")
                }
            case .failure(let failure):
                self.presentAlertMainThread(title: "Something Bad Happen", message: failure.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configDataSource(){
        dataSource=UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, followers)->UICollectionViewCell? in
            let cell=collectionView.dequeueReusableCell(withReuseIdentifier: GFCell.reuseId, for: indexPath) as! GFCell
            cell.config(follower: followers)
            return cell
        })
    }
    
    func updateData(data:[FolloworsModel]){
        var snapShot=NSDiffableDataSourceSnapshot<Section, FolloworsModel>()
        snapShot.appendSections([.main])
        snapShot.appendItems(data)
        DispatchQueue.main.async {
            self.dataSource.apply(snapShot, animatingDifferences: true)
        }
    }
    
    func configSearchController(){
        let searchTextField=UISearchController()
        searchTextField.searchResultsUpdater=self
        searchTextField.searchBar.delegate=self
        searchTextField.searchBar.placeholder="Enter username"
        navigationItem.searchController=searchTextField
    }

}
extension FollowersVC:UICollectionViewDelegate{
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY=scrollView.contentOffset.y /// it will changes according to scroll
        let contentHeight=scrollView.contentSize.height /// height of contet size if list contain (60,100) items
        let height=scrollView.frame.size.height /// depends on screen size

        if offsetY>contentHeight-height{
            guard hasMoreFollowers else {return}
            print("new followers")
            page += 1
            getFollowers(username: username, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray=isSearching ? filterFollowers : followers
        let data=activeArray[indexPath.item]
        let userinfoVc=UserInfoVC()
        userinfoVc.username=data.login
        userinfoVc.delegate=self
        present(UINavigationController(rootViewController: userinfoVc), animated: true)

    }
}

extension FollowersVC:UISearchResultsUpdating, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter=searchController.searchBar.text, !filter.isEmpty else {return}
        isSearching=true
        filterFollowers=followers.filter({ data in
            data.login.lowercased().contains(filter.lowercased())
        })
        updateData(data: filterFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching=false
        updateData(data: followers)
    }
    
    
}
//extension FollowersVC:UICollectionViewDelegate, UICollectionViewDataSource{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return followers.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: GFCell.reuseId, for: indexPath) as! GFCell
//        let followList=followers[indexPath.row]
//        if let url=URL(string: followList.avatar_url){
//            DispatchQueue.global().async {
//                if let data=try? Data(contentsOf: url){
//                    DispatchQueue.main.async {
//                        if let  image=UIImage(data: data){
////                            cell.config(follower: followList, image: image)
//                        }
//                      
//                    }
//                }
//            }
//        }
////        cell.config(follower: followList)
//        return cell
//    }
//}

extension FollowersVC:FollowersVCDelegate{
    func updateNewFollowers(with username: String) {
        self.username=username
        title=username
        page=1
        followers.removeAll()
        filterFollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        getFollowers(username: username, page: page)
    }
}
