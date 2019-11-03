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
    func validate(creditCardNumber: String) -> Bool
}

final class CredentialsValidatorUseCaseImpl: CredentialsValidatorUseCase {
    private let emailRegexPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    private let usernameRegexPattern = "(?!user\\d*)\\b[a-zA-Z\\d]{3,20}"
    private let passwordRegexPattern = "(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d!@#$&()-`.+,\\\"]{6,24}"
    private let creditCardRegexPattern = "(\\d{4}\\s{0,1}){4}"

    func validate(email: String) -> Bool {
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegexPattern)
        return emailPredicate.evaluate(with: email)
    }

    func validate(username: String) -> Bool {
        let usernamePredicate = NSPredicate(format: "SELF MATCHES %@", usernameRegexPattern)
        return usernamePredicate.evaluate(with: username)
    }

    func validate(password: String) -> Bool {
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegexPattern)
        return passwordPredicate.evaluate(with: password)
    }

    func validate(creditCardNumber: String) -> Bool {
        let creditCardPredicate = NSPredicate(format: "SELF MATCHES %@", creditCardRegexPattern)
        return creditCardPredicate.evaluate(with: creditCardNumber)
    }
}
