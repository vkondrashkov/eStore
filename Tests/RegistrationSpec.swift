//
//  RegistrationSpec.swift
//  Tests
//
//  Created by Vladislav Kondrashkov on 12/18/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import Quick
import Nimble
import Moya
import CoreData

@testable import eStore

final class RegistrationSpec: QuickSpec {
    final class AuthorizationRepositoryStub: AuthorizationRepository {
        var stubbedAuthorizeResult: Result<User, AuthorizationRepositoryError>!

        func authorize(login: String,
                       password: String,
                       completion: ((Result<User, AuthorizationRepositoryError>) -> Void)?) {
            completion?(stubbedAuthorizeResult)
        }

        func register(login: String, password: String, completion: ((Result<User, AuthorizationRepositoryError>) -> Void)?) {
            completion?(stubbedAuthorizeResult)
        }
    }

    final class UserRepositoryStub: UserRepository {
        var currentUser: User? = nil

        var stubbedSaveResult: Result<Bool, UserRepositoryError>!
        var stubbedLoadResult: Result<User, UserRepositoryError>!

        func saveUser(_ user: User, completion: ((Result<Bool, UserRepositoryError>) -> Void)?) {
            completion?(stubbedSaveResult)
        }

        func loadUser(completion: ((Result<User, UserRepositoryError>) -> Void)?) {
            completion?(stubbedLoadResult)
        }

        func removeUser(completion: ((UserRepositoryError?) -> Void)?) {
            completion?(nil)
        }
    }

    final class SignUpViewSpy: SignUpView {
        var invokedDisplayRightBarButton = false
        var invokedDisplayEmailCaption = false
        var invokedDisplayEmailError = false
        var invokedDisplayPasswordCaption = false
        var invokedDisplayPasswordError = false
        var invokedDisplayConfirmPasswordCaption = false
        var invokedDisplayConfirmPasswordError = false
        var invokedDisplaySignUpButton = false
        var invokedDisplayForgotPasswordButton = false
        var invokedShowActivityIndicator = false
        var invokedHideActivityIndicator = false
        var invokedUpdateThemeAnimated = false
        var invokedDisplayAlert = false

        func display(rightBarButton: String) {
            invokedDisplayRightBarButton = true
        }

        func display(emailCaption: String) {
            invokedDisplayEmailCaption = true
        }

        func display(emailError: String) {
            invokedDisplayEmailError = true
        }

        func display(passwordCaption: String) {
            invokedDisplayPasswordCaption = true
        }

        func display(passwordError: String) {
            invokedDisplayPasswordError = true
        }

        func display(confirmPasswordCaption: String) {
            invokedDisplayConfirmPasswordCaption = true
        }

        func display(confirmPasswordError: String) {
            invokedDisplayConfirmPasswordError = true
        }

        func display(signUpButton: String) {
            invokedDisplaySignUpButton = true
        }

        func showActivityIndicator() {
            invokedShowActivityIndicator = true
        }

        func hideActivityIndicator() {
            invokedShowActivityIndicator = true
        }

        func update(theme: Theme, animated: Bool) {
            invokedUpdateThemeAnimated = true
        }

        func display(alert: Alert) {
            invokedDisplayAlert = true
        }
    }

    final class SignUpRouterSpy: SignUpRouter {
        var invokedCompleteSignUp = false
        var invokedRouteSignUp = false

        func completeSignUp() {
            invokedCompleteSignUp = true
        }

        func routeSignIn() {
            invokedRouteSignUp = true
        }
    }

    final class ThemeManagerDummy: ThemeManager {
        var currentTheme: Theme = LightTheme(tintColorType: .azraqBlue)
        func applyTheme(_ theme: Theme) { }
        func add(observer: ThemeObserver) { }
        func remove(observer: ThemeObserver) { }
    }

    override func spec() {
        var expectedUser: User!
        var signUpViewSpy: SignUpViewSpy!
        var signUpRouterSpy: SignUpRouterSpy!
        var signUpPresenter: SignUpPresenter!
        var authorizationRepositoryStub: AuthorizationRepositoryStub!
        var userRepositoryStub: UserRepositoryStub!

        beforeEach {
            signUpViewSpy = SignUpViewSpy()
            signUpRouterSpy = SignUpRouterSpy()
            authorizationRepositoryStub = AuthorizationRepositoryStub()
            userRepositoryStub = UserRepositoryStub()
            signUpPresenter = SignUpPresenterImpl(
                view: signUpViewSpy,
                router: signUpRouterSpy,
                interactor: SignUpInteractorImpl(
                    credentialsValidatorUseCase: CredentialsValidatorUseCaseImpl(),
                    authorizationUseCase: AuthorizationUseCaseImpl(
                        authorizationRepository: authorizationRepositoryStub,
                        userRepository: userRepositoryStub,
                        userMapper: UserMapperImpl()
                    )
                ),
                themeManager: ThemeManagerDummy()
            )
        }

        // MARK: - When all repositories succeed

        context("when all repositories succeed") {
            beforeEach {
                expectedUser = User(
                    id: 1,
                    username: "stubUser",
                    email: "example@domain.com",
                    fullname: "Foo Bar",
                    role: .authorized
                )

                authorizationRepositoryStub.stubbedAuthorizeResult = .success(expectedUser)
                userRepositoryStub.stubbedSaveResult = .success(true)
                userRepositoryStub.stubbedLoadResult = .success(expectedUser)
            }

            it("should complete signIn when data is correct") {
                signUpPresenter.handleSignUpButtonPress(
                    login: "stubUser",
                    password: "A123456",
                    confirmPassword: "A123456"
                )
                expect(signUpRouterSpy.invokedCompleteSignUp).to(beTrue())
            }

            it("should display email error when email is empty but password is not") {
                signUpPresenter.handleSignUpButtonPress(
                    login: "",
                    password: "A123456",
                    confirmPassword: "A123456"
                )
                expect(signUpViewSpy.invokedDisplayEmailError).to(beTrue())
                expect(signUpViewSpy.invokedDisplayPasswordError).to(beFalse())
            }

            it("should display email error and password error when all data is empty") {
                signUpPresenter.handleSignUpButtonPress(
                    login: "",
                    password: "",
                    confirmPassword: ""
                )
                expect(signUpViewSpy.invokedDisplayEmailError).to(beTrue())
                expect(signUpViewSpy.invokedDisplayPasswordError).to(beTrue())
            }
        }

        // MARK: - When authorization repository fails

        context("when authorization repository fails") {
            beforeEach {
                expectedUser = User(
                    id: 1,
                    username: "stubUser",
                    email: "example@domain.com",
                    fullname: "Foo Bar",
                    role: .authorized
                )

                authorizationRepositoryStub.stubbedAuthorizeResult = .failure(.failed)
                userRepositoryStub.stubbedSaveResult = .success(true)
                userRepositoryStub.stubbedLoadResult = .success(expectedUser)
            }

            it("should display alert when data is correct") {
                signUpPresenter.handleSignUpButtonPress(
                    login: "stubUser",
                    password: "A123456",
                    confirmPassword: "A123456"
                )
                expect(signUpRouterSpy.invokedCompleteSignUp).to(beFalse())
                expect(signUpViewSpy.invokedDisplayAlert).to(beTrue())
            }

            it("should display email error when email is empty but password is not") {
                signUpPresenter.handleSignUpButtonPress(
                    login: "",
                    password: "A123456",
                    confirmPassword: "A123456"
                )
                expect(signUpViewSpy.invokedDisplayEmailError).to(beTrue())
                expect(signUpViewSpy.invokedDisplayPasswordError).to(beFalse())
            }

            it("should display email error and password error when all data is empty") {
                signUpPresenter.handleSignUpButtonPress(
                    login: "",
                    password: "",
                    confirmPassword: ""
                )
                expect(signUpViewSpy.invokedDisplayEmailError).to(beTrue())
                expect(signUpViewSpy.invokedDisplayPasswordError).to(beTrue())
            }
        }

        // MARK: - When user repository fails

        context("when user repository fails") {
            beforeEach {
                expectedUser = User(
                    id: 1,
                    username: "stubUser",
                    email: "example@domain.com",
                    fullname: "Foo Bar",
                    role: .authorized
                )

                authorizationRepositoryStub.stubbedAuthorizeResult = .success(expectedUser)
                userRepositoryStub.stubbedSaveResult = .failure(.failed)
                userRepositoryStub.stubbedLoadResult = .failure(.missingData)
            }

            it("should display alert when data is correct") {
                signUpPresenter.handleSignUpButtonPress(
                    login: "stubUser",
                    password: "A123456",
                    confirmPassword: "A123456"
                )
                expect(signUpRouterSpy.invokedRouteSignUp).to(beFalse())
                expect(signUpViewSpy.invokedDisplayAlert).to(beTrue())
            }

            it("should display email error when email is empty but password is not") {
                signUpPresenter.handleSignUpButtonPress(
                    login: "",
                    password: "A123456",
                    confirmPassword: "A123456"
                )
                expect(signUpViewSpy.invokedDisplayEmailError).to(beTrue())
                expect(signUpViewSpy.invokedDisplayPasswordError).to(beFalse())
            }

            it("should display email error and password error when all data is empty") {
                signUpPresenter.handleSignUpButtonPress(
                    login: "",
                    password: "",
                    confirmPassword: ""
                )
                expect(signUpViewSpy.invokedDisplayEmailError).to(beTrue())
                expect(signUpViewSpy.invokedDisplayPasswordError).to(beTrue())
            }
        }

        // MARK: - When all repository fails

        context("when all repository fails") {
            beforeEach {
                authorizationRepositoryStub.stubbedAuthorizeResult = .failure(.failed)
                userRepositoryStub.stubbedSaveResult = .failure(.failed)
                userRepositoryStub.stubbedLoadResult = .failure(.missingData)
            }

            it("should display alert when data is correct") {
                signUpPresenter.handleSignUpButtonPress(
                    login: "stubUser",
                    password: "A123456",
                    confirmPassword: "A123456"
                )
                expect(signUpRouterSpy.invokedCompleteSignUp).to(beFalse())
                expect(signUpViewSpy.invokedDisplayAlert).to(beTrue())
            }

            it("should display email error when email is empty but password is not") {
                signUpPresenter.handleSignUpButtonPress(
                    login: "",
                    password: "A123456",
                    confirmPassword: "A123456"
                )
                expect(signUpViewSpy.invokedDisplayEmailError).to(beTrue())
                expect(signUpViewSpy.invokedDisplayPasswordError).to(beFalse())
            }

            it("should display email error and password error when all data is empty") {
                signUpPresenter.handleSignUpButtonPress(
                    login: "",
                    password: "",
                    confirmPassword: ""
                )
                expect(signUpViewSpy.invokedDisplayEmailError).to(beTrue())
                expect(signUpViewSpy.invokedDisplayPasswordError).to(beTrue())
            }
        }
    }
}

// MARK: - Utils
private extension AuthorizationSpec {
    static func mockedPersistantContainer() -> NSPersistentContainer {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        let container = NSPersistentContainer(name: "eStore", managedObjectModel: managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false

        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            precondition(description.type == NSInMemoryStoreType)

            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
        }
        return container
    }

    static func errorEndpointClosure(target: eStoreAPI) -> Endpoint {
        return Endpoint(
            url: target.baseURL.absoluteString,
            sampleResponseClosure: { () -> EndpointSampleResponse in
                return .networkResponse(500, Data())
            },
            method: target.method,
            task: target.task,
            httpHeaderFields: target.headers
        )
    }
}

