//
//  NetworkLayer.swift
//  GithubSearch
//
//  Created by Mohd Kashif on 06/08/24.
//

import Foundation
import UIKit
final class NetworkLayer{
    static let shared=NetworkLayer()
    var cache=NSCache<NSString,UIImage>()
    private init(){}
    
    func getFollowers(username:String, page:Int, completion:@escaping (Result<[FolloworsModel], GFError>)->Void){
        //https://api.github.com/users/AdrianoFerrari/followers?per_page=4&page=1
        let endPoint=APIEndpoints.baseUrl+"\(username)/followers?per_page=\(APIEndpoints.perPage)&page=\(page)"
        guard let url=URL(string: endPoint) else {
            completion(.failure(.invlaidUrl))
            return
        }
        let dataTask=URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error{
                completion(.failure(.serverError))
                return
            }
            guard let data=data, let response=response as? HTTPURLResponse else {
                completion(.failure(.invalidData))
                return
            }
            if response.statusCode==200{
                do{
                    let decodedData=try JSONDecoder().decode([FolloworsModel].self, from: data)
                    completion(.success(decodedData))
                } catch _ {
                    completion(.failure(.invalidData))
                }
     
            } else {
                completion(.failure(.invalidData))
            }
            
        }
        dataTask.resume()

    }
}
