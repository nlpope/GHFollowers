//
//  User.swift
//  GHFollowers
//
//  Created by Noah Pope on 5/31/24.
//
//  User = what's focused on / expanded once a little follower is clicked


import Foundation

struct User: Codable {
    let login: String
    let avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let following: Int
    let followers: Int
    let createdAt: Date
}
