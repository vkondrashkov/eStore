//
//  RootInteractor.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 11/24/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

final class RootInteractorImpl {
    private let userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
}

// MARK: - RootInteractor implementation
extension RootInteractorImpl: RootInteractor {
    func loadUser(completion: ((_ succeed: Bool) -> Void)?) {
        userRepository.loadUser(completion: { result in
            switch result {
            case .success:
                completion?(true)
            case .failure:
                completion?(false)
            }
        })
    }
}
