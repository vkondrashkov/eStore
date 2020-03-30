//
//  RootAuthenticationSpec.swift
//  Tests
//
//  Created by Vladislav Kondrashkov on 12/18/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import Quick
import Nimble

@testable import eStore

final class RootAuthenticationSpec: QuickSpec {
    final private class RootViewDummy: RootView { }

    final private class RootRouterSpy: RootRouter {
        var invokedShowAuth = false
        var invokedShowDashboard = false

        func showAuth() {
            invokedShowAuth = true
        }

        func showDashboard() {
            invokedShowDashboard = true
        }
    }

    final private class UserRepositoryStub: UserRepository {
        var currentUser: User?

        var stubbedSaveUserResult: Result<Bool, UserRepositoryError>!
        var stubbedLoadUserResult: Result<User, UserRepositoryError>!
        var stubbedRemoveUserResult: UserRepositoryError?

        func saveUser(_ user: User, completion: ((Result<Bool, UserRepositoryError>) -> Void)?) {
            completion?(stubbedSaveUserResult)
        }

        func loadUser(completion: ((Result<User, UserRepositoryError>) -> Void)?) {
            completion?(stubbedLoadUserResult)
        }

        func removeUser(completion: ((UserRepositoryError?) -> Void)?) {
            completion?(stubbedRemoveUserResult)
        }
    }

    override func spec() {
        var rootPresenter: RootPresenter!
        var rootRouterSpy: RootRouterSpy!
        var userRepositoryStub: UserRepositoryStub!
        let rootViewDummy = RootViewDummy()

        describe("on handleViewAppear") {
            beforeEach {
                rootRouterSpy = RootRouterSpy()
                userRepositoryStub = UserRepositoryStub()
                rootPresenter = RootPresenterImpl(
                    view: rootViewDummy,
                    router: rootRouterSpy,
                    interactor: RootInteractorImpl(userRepository: userRepositoryStub)
                )
            }

            context("when user stored on device") {
                beforeEach {
                    userRepositoryStub.stubbedLoadUserResult = .success(User(
                        id: 1,
                        username: "stubUser",
                        email: "stubUser",
                        fullname: "Stub User",
                        role: .authorized
                    ))
                    rootPresenter.handleViewAppear()
                }

                it("should route user to dashboard") {
                    expect(rootRouterSpy.invokedShowDashboard).toEventually(beTrue())
                }
            }

            context("when user didn't store on device") {
                beforeEach {
                    userRepositoryStub.stubbedLoadUserResult = .failure(.missingData)
                    rootPresenter.handleViewAppear()
                }

                it("should route user to auth") {
                    expect(rootRouterSpy.invokedShowAuth).toEventually(beTrue())
                }
            }
        }
    }
}
