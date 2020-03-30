//
//  UserMapperSpec.swift
//  Tests
//
//  Created by Vladislav Kondrashkov on 12/18/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import Quick
import Nimble

@testable import eStore

final class UserMapperSpec: QuickSpec {
    override func spec() {
        var userMapper: UserMapper!

        describe("on userFromMappableUser") {
            beforeEach {
                userMapper = UserMapperImpl()
            }

            it("should return user when non empty data given") {
                let mappableUser = try? MappableUser(JSON: [
                    "id": 1,
                    "username": "stubUser",
                    "email": "example@domain.com",
                    "fullname": "Foo Bar",
                    "roleRawValue": 1
                ])
                guard let user = mappableUser else {
                    fail("Can't serialize MappableUser")
                    return
                }

                let mappedUser = userMapper.userFromMappableUser(user)
                expect(mappedUser?.id).to(equal(mappableUser?.id))
            }

            it("should return nil when only id given") {
                let mappableUser = try? MappableUser(JSON: ["id": 1])
                guard let user = mappableUser else {
                    fail("Can't serialize MappableUser")
                    return
                }

                let mappedUser = userMapper.userFromMappableUser(user)
                expect(mappedUser).to(beNil())
            }

            it("should return nil when username is missing") {
                let mappableUser = try? MappableUser(JSON: [
                    "id": 1,
                    "email": "example@domain.com",
                    "fullname": "Foo Bar",
                    "roleRawValue": 1
                ])
                guard let user = mappableUser else {
                    fail("Can't serialize MappableUser")
                    return
                }

                let mappedUser = userMapper.userFromMappableUser(user)
                expect(mappedUser).to(beNil())
            }
        }
    }
}
