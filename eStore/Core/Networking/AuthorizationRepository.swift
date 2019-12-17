//
//  AuthorizationRepository.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 11/25/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import Moya
import ObjectMapper

enum AuthorizationRepositoryError: Error {
    case invalidData
    case failed
}

protocol AuthorizationRepository {
    func authorize(login: String,
                   password: String,
                   completion: ((Result<User, AuthorizationRepositoryError>) -> Void)?)
    func register(login: String,
                  password: String,
                  completion: ((Result<User, AuthorizationRepositoryError>) -> Void)?)
}

final class AuthorizationRepositoryImpl {
    private let provider: MoyaProvider<eStoreAPI>
    private let userMapper: UserMapper

    init(provider: MoyaProvider<eStoreAPI>,
         userMapper: UserMapper) {
        self.provider = provider
        self.userMapper = userMapper
    }
}

// MARK: - AuthorizationRepository implementation
extension AuthorizationRepositoryImpl: AuthorizationRepository {
    func authorize(login: String,
                   password: String,
                   completion: ((Result<User, AuthorizationRepositoryError>) -> Void)?) {
        provider.request(.authorize(login: login, password: password)) { response in
            let result: Result<User, AuthorizationRepositoryError> = response
                .mapError { _ in
                    return .failed
                }
                .flatMap { data in
                    guard let json = try? data.mapJSON() as? [String: Any] else {
                        return .failure(.failed)
                    }
                    guard let mappableUser = Mapper<MappableUser>().map(JSON: json) else {
                        return .failure(.failed)
                    }
                    guard let user = self.userMapper.userFromMappableUser(mappableUser) else {
                        return .failure(.failed)
                    }
                    return .success(user)
                }
            completion?(result)
        }
    }

    func register(login: String,
                  password: String,
                  completion: ((Result<User, AuthorizationRepositoryError>) -> Void)?) {
        provider.request(.register(login: login, password: password)) { user in
            let result: Result<User, AuthorizationRepositoryError> = user
                .mapError { _ in
                    return .failed
                }
                .flatMap { data in
                    guard let json = try? data.mapJSON() as? [String: Any] else {
                        return .failure(.failed)
                    }
                    guard let mappableUser = Mapper<MappableUser>().map(JSON: json) else {
                        return .failure(.failed)
                    }
                    guard let user = self.userMapper.userFromMappableUser(mappableUser) else {
                        return .failure(.failed)
                    }
                    return .success(user)
                }
            completion?(result)
        }
    }
}
