//
//  APIEndpoints.swift
//  GithubSearch
//
//  Created by Mohd Kashif on 06/08/24.
//

import Foundation
enum APIEndpoints{
    static let baseUrl="https://api.github.com/users/"
    static let perPage=80
    static let htmlUrl="https://github.com/"
}

enum GFError:String, Error{
    case invlaidUrl="Username is invalid. Please provide correct name"
    case serverError="There is some error occur. Please try again"
    case invalidData="Server provide invalid data. Please try again"
    case alreadyExist="This user is already your favorite."
    
}
