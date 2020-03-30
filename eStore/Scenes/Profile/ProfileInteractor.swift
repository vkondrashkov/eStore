//
//  ProfileInteractor.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 12/17/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

final class ProfileInteractorImpl {
    private let userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
}

// MARK: - ProfileInteractor implementation

extension ProfileInteractorImpl: ProfileInteractor {
    var currentUser: User? {
        return userRepository.currentUser
    }

    func logout(completion: @escaping (ProfileInteractorError?) -> Void) {
        userRepository.removeUser(completion: { error in
            guard error == nil else {
                completion(.failed)
                return
            }
            completion(nil)
        })
    }
}
