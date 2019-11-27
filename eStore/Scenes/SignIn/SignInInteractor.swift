//
//  SignInInteractor.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 11/18/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

final class SignInInteractorImpl {
    private let credentialsValidatorUseCase: CredentialsValidatorUseCase
    private let authorizationUseCase: AuthorizationUseCase

    init(credentialsValidatorUseCase: CredentialsValidatorUseCase,
         authorizationUseCase: AuthorizationUseCase) {
        self.credentialsValidatorUseCase = credentialsValidatorUseCase
        self.authorizationUseCase = authorizationUseCase
    }
}

// MARK: - SignInInteractor implementation
extension SignInInteractorImpl: SignInInteractor {
    func validate(email: String) -> Bool {
        return credentialsValidatorUseCase.validate(email: email)
    }

    func validate(username: String) -> Bool {
        return credentialsValidatorUseCase.validate(username: username)
    }

    func validate(password: String) -> Bool {
        return credentialsValidatorUseCase.validate(password: password)
    }

    func signIn(login: String,
                password: String,
                completion: ((Result<User, SignInInteractorError>) -> Void)?) {
        authorizationUseCase.authorize(
            login: login,
            password: password,
            completion: { result in
                let user: Result<User, SignInInteractorError> = result
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
