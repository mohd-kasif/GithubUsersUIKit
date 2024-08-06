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
class FollowersVC: UIViewController {
    var username:String!
    private var followers:[FolloworsModel]=[]
    var dataSource:UICollectionViewDiffableDataSource<Section, FolloworsModel>!
    var collectionView:UICollectionView!
    var page:Int=1
    var hasMoreFollowers:Bool=true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden=false
        navigationController?.navigationBar.prefersLargeTitles=true
        

        configCollectionView()
        getFollowers(username: username, page: page)
        configDataSource()

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
        NetworkLayer.shared.getFollowers(username: username, page: page) {[weak self] result in
            guard let self=self else {return}
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    if success.count<APIEndpoints.perPage {
                        self.hasMoreFollowers=false
                    }
                    self.followers.append(contentsOf: success)
//                    self.collectionView.reloadData()
                    self.updateData()
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
    
    func updateData(){
        var snapShot=NSDiffableDataSourceSnapshot<Section, FolloworsModel>()
        snapShot.appendSections([.main])
        snapShot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapShot, animatingDifferences: true)
        }
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
