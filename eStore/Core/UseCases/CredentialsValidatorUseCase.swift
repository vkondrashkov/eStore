//
//  CredentialsValidatorUseCase.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 11/3/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import Foundation

protocol CredentialsValidatorUseCase {
    func validate(email: String) -> Bool
    func validate(username: String) -> Bool
    func validate(password: String) -> Bool
}

final class CredentialsValidatorUseCaseImpl: CredentialsValidatorUseCase {
    private let emailRegexPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    private let usernameRegexPattern = "user\\d*"
    private let specialCharactersRegexPattern = ".*[^A-Za-z0-9].*"

    func validate(email: String) -> Bool {
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegexPattern)
        return emailPredicate.evaluate(with: email)
    }

    func validate(username: String) -> Bool {
        guard username.count >= 3, username.count <= 20 else {
            return false
        }
        let usernamePredicate = NSPredicate(format: "NOT (SELF MATCHES %@) AND NOT (SELF MATCHES %@)", usernameRegexPattern, specialCharactersRegexPattern)
        return usernamePredicate.evaluate(with: username)
    }

    func validate(password: String) -> Bool {
        let passwordPredicate = NSPredicate(format: "NOT (SELF MATCHES %@)", specialCharactersRegexPattern)
        return passwordPredicate.evaluate(with: password)
    }
}
