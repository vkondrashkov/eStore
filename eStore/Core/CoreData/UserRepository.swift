//
//  UserManager.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 11/24/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import CoreData

enum UserRepositoryError: Error {
    case failed
    case missingData
}

protocol UserRepository {
    func saveUser(_ user: User,
                  completion: ((Result<Bool, UserRepositoryError>) -> Void)?)
    func loadUser(completion: ((Result<User, UserRepositoryError>) -> Void)?)
}

final class UserRepositoryImpl {
    private let persistentContainer: NSPersistentContainer

    private lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()

    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }

    convenience init() {
        let container = NSPersistentContainer(name: "eStore")
        container.loadPersistentStores(completionHandler: { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        self.init(persistentContainer: container)
    }
}

// MARK: - UserRepository implementation
extension UserRepositoryImpl: UserRepository {
    func saveUser(_ user: User, completion: ((Result<Bool, UserRepositoryError>) -> Void)?) {
        context.perform {
            let request = NSFetchRequest<UserData>(entityName: "UserData")
            if let result = try? self.context.fetch(request) {
                for userData in result {
                    self.context.delete(userData)
                }
            }
            let userData = NSEntityDescription.insertNewObject(forEntityName: "UserData", into: self.context) as! UserData
            userData.id = user.id
            userData.username = user.username
            userData.email = user.email
            userData.fullname = user.fullname
            userData.role = Int16(user.role.rawValue)
            self.context.saveAsyncInPerform { saved in
                completion?(.success(saved))
            }
        }
    }

    func loadUser(completion: ((Result<User, UserRepositoryError>) -> Void)?) {
        let request = NSFetchRequest<UserData>(entityName: "UserData")
        request.fetchLimit = 1
        persistentContainer.viewContext.perform {
            guard let result = try? self.context.fetch(request),
                let userData = result.first else {
                    completion?(.failure(.failed))
                    return
            }
            guard let user = UserMapperImpl().userFromUserData(userData) else {
                completion?(.failure(.missingData))
                return
            }
            self.context.saveAsyncInPerform { _ in
                completion?(.success(user))
            }
        }
    }

    func mapUserDataToUser(userData: UserData) -> User? {
        guard let id = userData.id,
            let username = userData.username,
            let role = User.Role(rawValue: Int(userData.role)) else {
                return nil
        }
        return User(
            id: id,
            username: username,
            email: userData.email,
            fullname: userData.fullname,
            role: role
        )
    }
}
