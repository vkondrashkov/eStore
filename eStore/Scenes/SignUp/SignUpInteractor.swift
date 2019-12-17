//
//  SignUpInteractor.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 12/17/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

final class SignUpInteractorImpl {
    private let credentialsValidatorUseCase: CredentialsValidatorUseCase
    private let authorizationUseCase: AuthorizationUseCase

    init(credentialsValidatorUseCase: CredentialsValidatorUseCase,
         authorizationUseCase: AuthorizationUseCase) {
        self.credentialsValidatorUseCase = credentialsValidatorUseCase
        self.authorizationUseCase = authorizationUseCase
    }
}

// MARK: - SignUpInteractor implementation
extension SignUpInteractorImpl: SignUpInteractor {
    func validate(email: String) -> Bool {
        return credentialsValidatorUseCase.validate(email: email)
    }

    func validate(username: String) -> Bool {
        return credentialsValidatorUseCase.validate(username: username)
    }

    func validate(password: String) -> Bool {
        return credentialsValidatorUseCase.validate(password: password)
    }

    func signUp(login: String,
                password: String,
                completion: ((Result<User, SignUpInteractorError>) -> Void)?) {
        authorizationUseCase.register(
            login: login,
            password: password,
            completion: { result in
                let user: Result<User, SignUpInteractorError> = result
                    .mapError {
                        switch $0 {
                        case .failed:
                            return .failed
                        case .invalidData:
                            return .invalidData
                        }
                    }
                completion?(user)
            }
        )
    }
}
