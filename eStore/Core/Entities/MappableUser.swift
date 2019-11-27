//
//  MappableUser.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 11/24/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import ObjectMapper

class MappableUser: ImmutableMappable {
    let id: String
    let username: String?
    let email: String?
    let fullname: String?
    let roleRawValue: Int?

    required init(map: Map) throws {
        id = try map.value("id")
        username = try? map.value("username")
        email = try? map.value("email")
        fullname = try? map.value("fullname")
        roleRawValue = try? map.value("role")
    }

    func mapping(map: Map) {
        id >>> map["id"]
        username >>> map["username"]
        email >>> map["email"]
        fullname >>> map["fullname"]
        roleRawValue >>> map["role"]
    }
}
