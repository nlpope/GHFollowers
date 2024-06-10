//
//  Follower.swift
//  GHFollowers
//
//  Created by Noah Pope on 5/31/24.
//  swift file not cocoa

import Foundation

struct Follower: Codable, Hashable {
    //camel case allowed for Codable's conversion to snake_case @ call site
    var login: String
    var avatarUrl: String
    
    
    //this hasher turns the login into a UUID for the diffable datasource
    func hash(into hasher: inout Hasher) {
        hasher.combine(login)
    }
}

