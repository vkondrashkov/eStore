//
//  LogoutSpec.swift
//  Tests
//
//  Created by Vladislav Kondrashkov on 12/18/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import Quick
import Nimble
import CoreData

@testable import eStore

final class LogoutSpec: QuickSpec {
    override func spec() {
        describe("on logout") {
            var interactor: ProfileInteractor!
            var userRepository: UserRepository!

            beforeEach {
                userRepository = UserRepositoryImpl(persistentContainer: LogoutSpec.mockedPersistantContainer())
                interactor = ProfileInteractorImpl(userRepository: userRepository)
            }

            it("should delete user from database") {
                waitUntil(timeout: 2, action: { done in
                    let user = User(id: 1, username: "stubUser", email: "stubUser", fullname: "stubUser", role: .authorized)
                    userRepository.saveUser(user, completion: { _ in
                        expect(userRepository.currentUser).notTo(beNil())
                        interactor.logout(completion: { _ in
                            expect(userRepository.currentUser).to(beNil())
                            done()
                        })
                    })
                })
            }
        }
    }
}

// MARK: - Utils

private extension LogoutSpec {
    static func mockedPersistantContainer() -> NSPersistentContainer {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        let container = NSPersistentContainer(name: "eStore", managedObjectModel: managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false

        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            precondition(description.type == NSInMemoryStoreType)

            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
        }
        return container
    }
}
