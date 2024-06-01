//
//  Follower.swift
//  GHFollowers
//
//  Created by Noah Pope on 5/31/24.
//  swift file not cocoa

import Foundation

struct Follower: Codable {
    //camel case allowed for Codable's auto-conversion to snake_case
    var login: String
    var avatarUrl: String
}
