//
//  AuthorizationSpec.swift
//  Tests
//
//  Created by Vladislav Kondrashkov on 11/24/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import Quick
import Nimble
import Moya
import CoreData

@testable import eStore

final class AuthorizationSpec: QuickSpec {
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

    final class SignInViewSpy: SignInView {
        var invokedDisplayRightBarButton = false
        var invokedDisplayEmailCaption = false
        var invokedDisplayEmailError = false
        var invokedDisplayPasswordCaption = false
        var invokedDisplayPasswordError = false
        var invokedDisplaySignInButton = false
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

        func display(signInButton: String) {
            invokedDisplaySignInButton = true
        }

        func display(forgotPasswordButton: String) {
            invokedDisplayForgotPasswordButton = true
        }

        func showActivityIndicator() {
            invokedShowActivityIndicator = true
        }

        func hideActivityIndicator() {
            invokedHideActivityIndicator = true
        }

        func update(theme: Theme, animated: Bool) {
            invokedUpdateThemeAnimated = true
        }

        func display(alert: Alert) {
            invokedDisplayAlert = true
        }
    }

    final class SignInRouterSpy: SignInRouter {
        var invokedCompleteSignIn = false
        var invokedRouteSignUp = false

        func completeSignIn() {
            invokedCompleteSignIn = true
        }

        func routeSignUp() {
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
        var signInViewSpy: SignInViewSpy!
        var signInRouterSpy: SignInRouterSpy!
        var signInPresenter: SignInPresenter!
        var authorizationRepositoryStub: AuthorizationRepositoryStub!
        var userRepositoryStub: UserRepositoryStub!

        beforeEach {
            signInViewSpy = SignInViewSpy()
            signInRouterSpy = SignInRouterSpy()
            authorizationRepositoryStub = AuthorizationRepositoryStub()
            userRepositoryStub = UserRepositoryStub()
            signInPresenter = SignInPresenterImpl(
                view: signInViewSpy,
                router: signInRouterSpy,
                interactor: SignInInteractorImpl(
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
                signInPresenter.handleSignInButtonPress(login: "stubUser", password: "A123456")
                expect(signInRouterSpy.invokedCompleteSignIn).to(beTrue())
            }

            it("should display email error when email is empty but password is not") {
                signInPresenter.handleSignInButtonPress(login: "", password: "A123456")
                expect(signInViewSpy.invokedDisplayEmailError).to(beTrue())
                expect(signInViewSpy.invokedDisplayPasswordError).to(beFalse())
            }

            it("should display email error and password error when all data is empty") {
                signInPresenter.handleSignInButtonPress(login: "", password: "")
                expect(signInViewSpy.invokedDisplayEmailError).to(beTrue())
                expect(signInViewSpy.invokedDisplayPasswordError).to(beTrue())
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
                signInPresenter.handleSignInButtonPress(login: "stubUser", password: "A123456")
                expect(signInRouterSpy.invokedCompleteSignIn).to(beFalse())
                expect(signInViewSpy.invokedDisplayAlert).to(beTrue())
            }

            it("should display email error when email is empty but password is not") {
                signInPresenter.handleSignInButtonPress(login: "", password: "A123456")
                expect(signInViewSpy.invokedDisplayEmailError).to(beTrue())
                expect(signInViewSpy.invokedDisplayPasswordError).to(beFalse())
            }

            it("should display email error and password error when all data is empty") {
                signInPresenter.handleSignInButtonPress(login: "", password: "")
                expect(signInViewSpy.invokedDisplayEmailError).to(beTrue())
                expect(signInViewSpy.invokedDisplayPasswordError).to(beTrue())
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
                signInPresenter.handleSignInButtonPress(login: "stubUser", password: "A123456")
                expect(signInRouterSpy.invokedCompleteSignIn).to(beFalse())
                expect(signInViewSpy.invokedDisplayAlert).to(beTrue())
            }

            it("should display email error when email is empty but password is not") {
                signInPresenter.handleSignInButtonPress(login: "", password: "A123456")
                expect(signInViewSpy.invokedDisplayEmailError).to(beTrue())
                expect(signInViewSpy.invokedDisplayPasswordError).to(beFalse())
            }

            it("should display email error and password error when all data is empty") {
                signInPresenter.handleSignInButtonPress(login: "", password: "")
                expect(signInViewSpy.invokedDisplayEmailError).to(beTrue())
                expect(signInViewSpy.invokedDisplayPasswordError).to(beTrue())
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
                signInPresenter.handleSignInButtonPress(login: "stubUser", password: "A123456")
                expect(signInRouterSpy.invokedCompleteSignIn).to(beFalse())
                expect(signInViewSpy.invokedDisplayAlert).to(beTrue())
            }

            it("should display email error when email is empty but password is not") {
                signInPresenter.handleSignInButtonPress(login: "", password: "A123456")
                expect(signInViewSpy.invokedDisplayEmailError).to(beTrue())
                expect(signInViewSpy.invokedDisplayPasswordError).to(beFalse())
            }

            it("should display email error and password error when all data is empty") {
                signInPresenter.handleSignInButtonPress(login: "", password: "")
                expect(signInViewSpy.invokedDisplayEmailError).to(beTrue())
                expect(signInViewSpy.invokedDisplayPasswordError).to(beTrue())
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
