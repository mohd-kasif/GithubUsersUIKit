//
//  PersistanceManager.swift
//  GithubSearch
//
//  Created by Mohd Kashif on 08/08/24.
//

import Foundation
enum PersistanceType{
    case add, delete
}
enum PersistanceManager{
    static private let defaults=UserDefaults.standard
    
    static func updateWith(favorite:FolloworsModel, persistenceType:PersistanceType, completion:@escaping (GFError?)->Void){
        retriveFavorite { result in
            switch result {
                
            case .success(let favoriteList):
                var myFavorite=favoriteList
                switch persistenceType {
                case .add:
                    guard !myFavorite.contains(favorite) else {
                        completion(.alreadyExist)
                        return
                    }
                    myFavorite.append(favorite)
                case .delete:
                    myFavorite.removeAll { val in
                        val.login==favorite.login
                    }
                }
                completion(save(favorites: myFavorite))
 
            case .failure(_):
                completion(.invalidData)
            }
        }
    }
    
    static func retriveFavorite(completion:@escaping (Result<[FolloworsModel], GFError>)->Void){
        guard let favorites=defaults.object(forKey: Keys.favorites) as? Data else {
            completion(.success([]))
            return
        }
        do{
            let decodedData=try JSONDecoder().decode([FolloworsModel].self, from: favorites)
            completion(.success(decodedData))
        } catch _ {
            completion(.failure(.invalidData))
        }
    }
    
    static func save(favorites:[FolloworsModel])->GFError?{
        do{
            let decodedData=try JSONEncoder().encode(favorites)
            defaults.setValue(decodedData, forKey: Keys.favorites)
            return nil
        } catch _ {
            return .invalidData
        }
    }
}
