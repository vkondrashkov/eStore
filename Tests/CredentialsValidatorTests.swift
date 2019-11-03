//
//  CredentialsValidatorTests.swift
//  Tests
//
//  Created by Vladislav Kondrashkov on 11/3/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import XCTest
@testable import eStore

class CredentialsValidatorTests: XCTestCase {
    private var validator: CredentialsValidatorUseCase!

    override func setUp() {
        validator = CredentialsValidatorUseCaseImpl()
    }

    override func tearDown() { }

    // MARK: - Username validation

    func testSuccessfullUsernameValidation() {
        // Given
        let username = "declipz"

        // When
        let validationResult = validator.validate(username: username)

        // Then
        XCTAssert(validationResult, "Username 'declipz' should be valid.")
    }

    func testDefaultUsernameValidation() {
        // Given
        let username = "user123"

        // When
        let validationResult = validator.validate(username: username)

        // Then
        XCTAssert(!validationResult, "Username 'user123' shouldn't be valid. Simillar to default usernames.")
    }

    func testShortUsernameValidation() {
        // Given
        let username = "us"

        // When
        let validationResult = validator.validate(username: username)

        // Then
        XCTAssert(!validationResult, "Username 'us' shouldn't be valid. Too short.")
    }

    func testLongUsernameValidation() {
        // Given
        let username = "usernameWhichContainsTooSymbolsThatAreNotFitString"

        // When
        let validationResult = validator.validate(username: username)

        // Then
        XCTAssert(!validationResult, "Username 'usernameWhichContainsTooSymbolsThatAreNotFitString' shouldn't be valid. Too long.")
    }

    func testSpecialCharactersUsernameValidation() {
        // Given
        let username = "d3cl!p$"

        // When
        let validationResult = validator.validate(username: username)

        // Then
        XCTAssert(!validationResult, "Username 'd3cl!p$' shouldn't be valid. Special characters are not allowed in username.")
    }

    // MARK: - Email validation

    func testSuccessfulEmailValidation() {
        // Given
        let email = "example@domain.com"

        // When
        let validationResult = validator.validate(email: email)

        // Then
        XCTAssert(validationResult, "Email 'example@domain.com' should be valid.")
    }

    func testNotEmailValidation() {
        // Given
        let email = "somethingThatCant@beEmail"

        // When
        let validationResult = validator.validate(email: email)

        // Then
        XCTAssert(!validationResult, "Email 'somethingThatCant@beEmail' shouldn't be valid. Doesn't contain domain.")
    }

    func testShortEmailValidation() {
        // Given
        let email = "sh@or.t"

        // When
        let validationResult = validator.validate(email: email)

        // Then
        XCTAssert(!validationResult, "Email 'sh@or.t' shouldn't be valid. Too short.")
    }

    // MARK: - Password validation

    func testSuccessfulPasswordValidation() {
        // Given
        let password = "fooBar123456"

        // When
        let validationResult = validator.validate(password: password)

        // Then
        XCTAssert(validationResult, "Password 'fooBar123456' should be valid.")
    }

    func testShortPasswordValidation() {
        // Given
        let password = "foo"

        // When
        let validationResult = validator.validate(password: password)

        // Then
        XCTAssert(!validationResult, "Password 'foo' shouldn't be valid. Too short.")
    }

    func testLongPasswordValidation() {
        // Given
        let password = "thisIsToo123LongPassword123AndShouldntBeValid"

        // When
        let validationResult = validator.validate(password: password)

        // Then
        XCTAssert(!validationResult, "Password 'thisIsToo123LongPassword123AndShouldntBeValid' shouldn't be valid. Too long.")
    }

    func testOnlySymbolPasswordValidation() {
        // Given
        let password = "onlySymbolPass"

        // When
        let validationResult = validator.validate(password: password)

        // Then
        XCTAssert(!validationResult, "Password 'onlySymbolPass' shouldn't be valid. Doesn't contain digits.")
    }

    func testOnlyDigitPasswordValidation() {
        // Given
        let password = "123456789"

        // When
        let validationResult = validator.validate(password: password)

        // Then
        XCTAssert(!validationResult, "Password '123456789' shouldn't be valid. Doesn't contain symbols.")
    }

    func testSpecialCharactersPasswordValidation() {
        // Given
        let password = "this$#@123Pass"

        // When
        let validationResult = validator.validate(password: password)

        // Then
        XCTAssert(validationResult, "Password 'this$#@123Pass' should be valid. Special characters are allowed in password.")
    }

    // MARK: - Credit card validation

    func testSuccessfullSpacedCreditCardValidation() {
        // Given
        let creditCardNumber = "1111 2222 3333 4444"

        // When
        let validationResult = validator.validate(creditCardNumber: creditCardNumber)

        // Then
        XCTAssert(validationResult, "Credit card '1111 2222 3333 4444' should be valid.")
    }

    func testSuccessfullTrimmedCreditCardValidation() {
        // Given
        let creditCardNumber = "1111222233334444"

        // When
        let validationResult = validator.validate(creditCardNumber: creditCardNumber)

        // Then
        XCTAssert(validationResult, "Credit card '1111222233334444' should be valid.")
    }

    func testSymbolSpacedCreditCardValidation() {
        // Given
        let creditCardNumber = "!111 2@22 33#3 444$"

        // When
        let validationResult = validator.validate(creditCardNumber: creditCardNumber)

        // Then
        XCTAssert(!validationResult, "Credit card '!111 2@22 33#3 444$' shouldn't be valid. Only digits are allowed.")
    }

    func testSymbolTrimmedCreditCardValidation() {
        // Given
        let creditCardNumber = "!1112@2233#3444$"

        // When
        let validationResult = validator.validate(creditCardNumber: creditCardNumber)

        // Then
        XCTAssert(!validationResult, "Credit card '!1112@2233#3444$' shouldn't be valid. Only digits are allowed.")
    }

    func testShortSpacedCreditCardValidation() {
        // Given
        let creditCardNumber = "1111 2222 3333 444"

        // When
        let validationResult = validator.validate(creditCardNumber: creditCardNumber)

        // Then
        XCTAssert(!validationResult, "Credit card '1111 2222 3333 444' shouldn't be valid. Not enough digits.")
    }

    func testShortTrimmedCreditCardValidation() {
        // Given
        let creditCardNumber = "111122223333444"

        // When
        let validationResult = validator.validate(creditCardNumber: creditCardNumber)

        // Then
        XCTAssert(!validationResult, "Credit card '111122223333444' shouldn't be valid. Not enough digits.")
    }

    func testLongSpacedCreditCardValidation() {
        // Given
        let creditCardNumber = "1111 2222 3333 4444 5"

        // When
        let validationResult = validator.validate(creditCardNumber: creditCardNumber)

        // Then
        XCTAssert(!validationResult, "Credit card '1111 2222 3333 4444 5' shouldn't be valid. A lot of digits.")
    }

    func testLongTrimmedCreditCardValidation() {
        // Given
        let creditCardNumber = "11112222333344445"

        // When
        let validationResult = validator.validate(creditCardNumber: creditCardNumber)

        // Then
        XCTAssert(!validationResult, "Credit card '11112222333344445' shouldn't be valid. A lot of digits.")
    }
}
