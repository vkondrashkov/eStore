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
        XCTAssertTrue(validationResult)
    }

    func testDefaultUsernameValidation() {
        // Given
        let username = "user123"

        // When
        let validationResult = validator.validate(username: username)

        // Then
        XCTAssertFalse(validationResult)
    }

    func testShortUsernameValidation() {
        // Given
        let username = "us"

        // When
        let validationResult = validator.validate(username: username)

        // Then
        XCTAssertFalse(validationResult)
    }

    func testLongUsernameValidation() {
        // Given
        let username = "usernameWhichContainsTooSymbolsThatAreNotFitString"

        // When
        let validationResult = validator.validate(username: username)

        // Then
        XCTAssertFalse(validationResult)
    }

    func testSpecialCharactersUsernameValidation() {
        // Given
        let username = "d3cl!p$"

        // When
        let validationResult = validator.validate(username: username)

        // Then
        XCTAssertFalse(validationResult)
    }

    // MARK: - Email validation

    func testSuccessfulEmailValidation() {
        // Given
        let email = "example@domain.com"

        // When
        let validationResult = validator.validate(email: email)

        // Then
        XCTAssertTrue(validationResult)
    }

    func testNotEmailValidation() {
        // Given
        let email = "somethingThatCant@beEmail"

        // When
        let validationResult = validator.validate(email: email)

        // Then
        XCTAssertFalse(validationResult)
    }

    func testShortEmailValidation() {
        // Given
        let email = "sh@or.t"

        // When
        let validationResult = validator.validate(email: email)

        // Then
        XCTAssertFalse(validationResult)
    }

    func testLongEmailValidation() {
        // Given
        let email = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa@ aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa. aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"

        // When
        let validationResult = validator.validate(email: email)

        // Then
        XCTAssertFalse(validationResult)
    }

    // MARK: - Password validation

    func testSuccessfulPasswordValidation() {
        // Given
        let password = "fooBar123456"

        // When
        let validationResult = validator.validate(password: password)

        // Then
        XCTAssertTrue(validationResult)
    }

    func testShortPasswordValidation() {
        // Given
        let password = "foo"

        // When
        let validationResult = validator.validate(password: password)

        // Then
        XCTAssertFalse(validationResult)
    }

    func testLongPasswordValidation() {
        // Given
        let password = "thisIsToo123LongPassword123AndShouldntBeValid"

        // When
        let validationResult = validator.validate(password: password)

        // Then
        XCTAssertFalse(validationResult)
    }

    func testOnlySymbolPasswordValidation() {
        // Given
        let password = "onlySymbolPass"

        // When
        let validationResult = validator.validate(password: password)

        // Then
        XCTAssertFalse(validationResult)
    }

    func testOnlyDigitPasswordValidation() {
        // Given
        let password = "123456789"

        // When
        let validationResult = validator.validate(password: password)

        // Then
        XCTAssertFalse(validationResult)
    }

    func testSpecialCharactersPasswordValidation() {
        // Given
        let password = "this$#@123Pass"

        // When
        let validationResult = validator.validate(password: password)

        // Then
        XCTAssertTrue(validationResult)
    }

    // MARK: - Credit card validation

    func testSuccessfullSpacedCreditCardValidation() {
        // Given
        let creditCardNumber = "1111 2222 3333 4444"

        // When
        let validationResult = validator.validate(creditCardNumber: creditCardNumber)

        // Then
        XCTAssertTrue(validationResult)
    }

    func testSuccessfullTrimmedCreditCardValidation() {
        // Given
        let creditCardNumber = "1111222233334444"

        // When
        let validationResult = validator.validate(creditCardNumber: creditCardNumber)

        // Then
        XCTAssertTrue(validationResult)
    }

    func testSymbolSpacedCreditCardValidation() {
        // Given
        let creditCardNumber = "!111 2@22 33#3 444$"

        // When
        let validationResult = validator.validate(creditCardNumber: creditCardNumber)

        // Then
        XCTAssertFalse(validationResult)
    }

    func testSymbolTrimmedCreditCardValidation() {
        // Given
        let creditCardNumber = "!1112@2233#3444$"

        // When
        let validationResult = validator.validate(creditCardNumber: creditCardNumber)

        // Then
        XCTAssertFalse(validationResult)
    }

    func testShortSpacedCreditCardValidation() {
        // Given
        let creditCardNumber = "1111 2222 3333 444"

        // When
        let validationResult = validator.validate(creditCardNumber: creditCardNumber)

        // Then
        XCTAssertFalse(validationResult)
    }

    func testShortTrimmedCreditCardValidation() {
        // Given
        let creditCardNumber = "111122223333444"

        // When
        let validationResult = validator.validate(creditCardNumber: creditCardNumber)

        // Then
        XCTAssertFalse(validationResult)
    }

    func testLongSpacedCreditCardValidation() {
        // Given
        let creditCardNumber = "1111 2222 3333 4444 5"

        // When
        let validationResult = validator.validate(creditCardNumber: creditCardNumber)

        // Then
        XCTAssertFalse(validationResult)
    }

    func testLongTrimmedCreditCardValidation() {
        // Given
        let creditCardNumber = "11112222333344445"

        // When
        let validationResult = validator.validate(creditCardNumber: creditCardNumber)

        // Then
        XCTAssertFalse(validationResult)
    }
}
