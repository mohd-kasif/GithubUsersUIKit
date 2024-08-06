//
//  FolloworsModel.swift
//  GithubSearch
//
//  Created by Mohd Kashif on 06/08/24.
//
/*
 "login": "ScotterC",
  "id": 313254,
  "node_id": "MDQ6VXNlcjMxMzI1NA==",
  "avatar_url": "https://avatars.githubusercontent.com/u/313254?v=4",
  "gravatar_id": "",
  "url": "https://api.github.com/users/ScotterC",
  "html_url": "https://github.com/ScotterC",
  "followers_url": "https://api.github.com/users/ScotterC/followers",
  "following_url": "https://api.github.com/users/ScotterC/following{/other_user}",
  "gists_url": "https://api.github.com/users/ScotterC/gists{/gist_id}",
  "starred_url": "https://api.github.com/users/ScotterC/starred{/owner}{/repo}",
  "subscriptions_url": "https://api.github.com/users/ScotterC/subscriptions",
  "organizations_url": "https://api.github.com/users/ScotterC/orgs",
  "repos_url": "https://api.github.com/users/ScotterC/repos",
  "events_url": "https://api.github.com/users/ScotterC/events{/privacy}",
  "received_events_url": "https://api.github.com/users/ScotterC/received_events",
  "type": "User",
  "site_admin": false
 */
import Foundation

struct FolloworsModel:Codable,Hashable{
    let login:String
    let avatar_url:String
}
/*
 {
   "login": "AdrianoFerrari",
   "id": 323678,
   "node_id": "MDQ6VXNlcjMyMzY3OA==",
   "avatar_url": "https://avatars.githubusercontent.com/u/323678?v=4",
   "gravatar_id": "",
   "url": "https://api.github.com/users/AdrianoFerrari",
   "html_url": "https://github.com/AdrianoFerrari",
   "followers_url": "https://api.github.com/users/AdrianoFerrari/followers",
   "following_url": "https://api.github.com/users/AdrianoFerrari/following{/other_user}",
   "gists_url": "https://api.github.com/users/AdrianoFerrari/gists{/gist_id}",
   "starred_url": "https://api.github.com/users/AdrianoFerrari/starred{/owner}{/repo}",
   "subscriptions_url": "https://api.github.com/users/AdrianoFerrari/subscriptions",
   "organizations_url": "https://api.github.com/users/AdrianoFerrari/orgs",
   "repos_url": "https://api.github.com/users/AdrianoFerrari/repos",
   "events_url": "https://api.github.com/users/AdrianoFerrari/events{/privacy}",
   "received_events_url": "https://api.github.com/users/AdrianoFerrari/received_events",
   "type": "User",
   "site_admin": false,
   "name": "Adriano Ferrari",
   "company": "Gingko Inc",
   "blog": "https://gingkowriter.com",
   "location": "Gatineau, Quebec, Canada",
   "email": null,
   "hireable": null,
   "bio": null,
   "twitter_username": "gingkoapp",
   "public_repos": 22,
   "public_gists": 5,
   "followers": 46,
   "following": 16,
   "created_at": "2010-07-05T21:51:47Z",
   "updated_at": "2024-07-04T13:24:35Z"
 }
 */
struct UserModel:Codable{
    let login:String
    let avatar_url:String
    let name:String?
    let location:String?
    let bio:String?
    let public_repos:Int
    let public_gists:Int
    let html_url:String
    let following:Int
    let followers:Int
    let created_at:String
}
