//
//  User.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 11/18/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

class User {
    enum Role: Int {
        case guest = 0
        case authorized
        case contentMaker
        case moderator
        case admin
    }

    let id: String
    let username: String
    let email: String?
    let fullname: String?
    let role: User.Role

    init(id: String,
         username: String,
         email: String?,
         fullname: String?,
         role: User.Role) {
        self.id = id
        self.username = username
        self.email = email
        self.fullname = fullname
        self.role = role
    }
}
