//
//  CartRepositorySpec.swift
//  Tests
//
//  Created by Vladislav Kondrashkov on 12/18/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import Quick
import Nimble
import Moya

@testable import eStore

final class CartRepositorySpec: QuickSpec {
    override func spec() {
        var cartRepository: CartRepository!

        // MARK: - When repository succeeds

        context("when repository succeeds") {
            beforeEach {
                cartRepository = CartRepositoryImpl(
                    provider: MoyaProvider<eStoreAPI>(stubClosure: MoyaProvider.immediatelyStub)
                )
            }

            it("should return empty cart when user has no purchases") {
                var receivedResult: Result<[CartItem], CartRepositoryError>?
                cartRepository.fetchCart(userId: 2, completion: { result in
                    receivedResult = result
                })
                expect(receivedResult?.value).to(beNil())
            }

            it("should return non empty cart when user has purchases") {
                var receivedResult: Result<[CartItem], CartRepositoryError>?
                cartRepository.fetchCart(userId: 1, completion: { result in
                    receivedResult = result
                })
                expect(receivedResult?.value).notTo(beNil())
            }
        }

        // MARK: - When repository fails

        context("when repository succeeds") {
            beforeEach {
                cartRepository = CartRepositoryImpl(
                    provider: MoyaProvider<eStoreAPI>(
                        endpointClosure: CartRepositorySpec.errorEndpointClosure,
                        stubClosure: MoyaProvider.immediatelyStub
                    )
                )
            }

            it("should return error cart when user has no purchases") {
                var receivedResult: Result<[CartItem], CartRepositoryError>?
                cartRepository.fetchCart(userId: 2, completion: { result in
                    receivedResult = result
                })
                expect(receivedResult?.error).notTo(beNil())
            }

            it("should return error cart when user has purchases") {
                var receivedResult: Result<[CartItem], CartRepositoryError>?
                cartRepository.fetchCart(userId: 1, completion: { result in
                    receivedResult = result
                })
                expect(receivedResult?.error).notTo(beNil())
            }
        }
    }
}

// MARK: - Utils

extension CartRepositorySpec {
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

