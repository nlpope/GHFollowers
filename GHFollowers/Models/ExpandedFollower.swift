//
//  ExpandedFollower.swift
//  GHFollowers
//
//  Created by Noah Pope on 5/31/24.
//  OG name = User

import Foundation

struct ExpandedFollower: Codable {
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
    let createdAt: String
}
