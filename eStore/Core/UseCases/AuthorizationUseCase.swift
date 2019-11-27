//
//  AuthorizationUseCase.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 11/18/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

enum AuthorizationUseCaseError: Error {
    case invalidData
    case failed
}

protocol AuthorizationUseCase {
    func authorize(login: String,
                   password: String,
                   completion: ((Result<User, AuthorizationUseCaseError>) -> Void)?)
}

final class AuthorizationUseCaseImpl {
    private let authorizationRepository: AuthorizationRepository
    private let userRepository: UserRepository
    private let userMapper: UserMapper

    init(authorizationRepository: AuthorizationRepository,
         userRepository: UserRepository,
         userMapper: UserMapper) {
        self.authorizationRepository = authorizationRepository
        self.userRepository = userRepository
        self.userMapper = userMapper
    }
}

// MARK: - AuthorizationUseCase implementation
extension AuthorizationUseCaseImpl: AuthorizationUseCase {
    func authorize(login: String,
                   password: String,
                   completion: ((Result<User, AuthorizationUseCaseError>) -> Void)?) {
        authorizationRepository.authorize(
            login: login,
            password: password,
            completion: { [weak self] authorization in
                guard let self = self else { return }
                let authorization = authorization
                    .mapError { error -> AuthorizationUseCaseError in
                        switch error {
                        case .failed:
                            return .failed
                        case .invalidData:
                            return .invalidData
                        }
                    }
                guard let user = authorization.value else {
                    completion?(authorization)
                    return
                }
                self.userRepository.saveUser(user, completion: { saved in
                    let result: Result<User, AuthorizationUseCaseError> = saved
                        .mapError { _ in AuthorizationUseCaseError.failed }
                        .flatMap {
                            if $0 {
                                return .success(user)
                            } else {
                                return .failure(.failed)
                            }
                        }
                    completion?(result)
                })
            }
        )
    }
}
