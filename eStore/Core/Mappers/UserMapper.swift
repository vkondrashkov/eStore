//
//  UserMapper.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 11/24/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

protocol UserMapper {
    func userFromMappableUser(_ mappableUser: MappableUser) -> User?

    func userFromUserData(_ userData: UserData) -> User?
}

final class UserMapperImpl: UserMapper {
    func userFromMappableUser(_ mappableUser: MappableUser) -> User? {
        guard let username = mappableUser.username else {
            return nil
        }
        return User(
            id: mappableUser.id,
            username: username,
            email: mappableUser.email,
            fullname: mappableUser.fullname,
            role: User.Role(rawValue: mappableUser.roleRawValue ?? 0) ?? .guest
        )
    }

    func userFromUserData(_ userData: UserData) -> User? {
        guard let userId = userData.id,
            let id = Int(userId),
            let username = userData.username else {
                return nil
        }
        let roleRawValue = Int(userData.role)

        return User(
            id: id,
            username: username,
            email: userData.email,
            fullname: userData.fullname,
            role: User.Role(rawValue: roleRawValue) ?? .guest
        )
    }
}
