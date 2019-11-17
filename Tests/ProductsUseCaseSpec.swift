//
//  ProductsUseCaseSpec.swift
//  Tests
//
//  Created by Vladislav Kondrashkov on 11/16/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import Quick
import Nimble
import Moya

@testable import eStore

final class ProductsUseCaseSpec: QuickSpec {
    override func spec() {
        var productsUseCase: ProductsUseCase!

        beforeEach {
            let provider = MoyaProvider<eStore>(stubClosure: MoyaProvider.immediatelyStub)
            let repository = ProductsRepositoryImpl(provider: provider)
            productsUseCase = ProductsUseCaseImpl(repository: repository)
        }

        // MARK: - fetchSmartphone(id:)

        describe("on fetchSmartphone(id:)") {
            context("with wrong id") {
                it("should return error") {
                    var receivedError: Error?
                    productsUseCase.fetchSmartphone(
                        id: "wrongId",
                        completion: { result in
                            switch result {
                            case .success:
                                fail("Expected call fetchSmarpthone(id:) to fail, but it succeed.")
                            case .failure(let error):
                                receivedError = error
                            }
                        }
                    )
                    expect(receivedError).toNotEventually(beNil())
                }
            }

            context("with correct id") {
                let id = "3571539fcbe330452d4d938502ed9f15"
                it("should return success") {
                    var receivedSmartphone: Smartphone?
                    productsUseCase.fetchSmartphone(
                        id: id,
                        completion: { result in
                            switch result {
                            case .success(let smartphone):
                                receivedSmartphone = smartphone
                            case .failure:
                                fail("Expected call fetchSmarpthone(id:) to succeed, but it failed.")
                            }
                        }
                    )
                    expect(receivedSmartphone?.id).toEventually(equal(id))
                }
            }
        }

        // MARK: - fetchSmartphones(:)

        describe("on fetchSmarphones(:)") {
            context("when repository fails") {
                it("should return error") {
                    productsUseCase = self.mockFailureUseCase()
                    var receivedError: Error?
                    productsUseCase.fetchSmartphones(
                        completion: { result in
                            switch result {
                            case .success:
                                fail("Expected call fetchSmarpthones(:) to fail, but it succeed.")
                            case .failure(let error):
                                receivedError = error
                            }
                        }
                    )
                    expect(receivedError).toNotEventually(beNil())
                }
            }

            it("should return success") {
                var receivedSmartphones: [Smartphone]?
                productsUseCase.fetchSmartphones(
                    completion: { result in
                        switch result {
                        case .success(let smartphones):
                            receivedSmartphones = smartphones
                        case .failure:
                            fail("Expected call fetchSmarpthone(id:) to succeed, but it failed.")
                        }
                    }
                )
                expect(receivedSmartphones).toNotEventually(beEmpty())
            }
        }

        // MARK: - fetchLaptop(id:)

        describe("on fetchLaptop(id:)") {
            context("with wrong id") {
                it("should return error") {
                    var receivedError: Error?
                    productsUseCase.fetchLaptop(
                        id: "wrongId",
                        completion: { result in
                            switch result {
                            case .success:
                                fail("Expected call fetchLaptop(id:) to fail, but it succeed.")
                            case .failure(let error):
                                receivedError = error
                            }
                        }
                    )
                    expect(receivedError).toNotEventually(beNil())
                }
            }

            context("with correct id") {
                let id = "34ec91a46a12a40fc44c414b61b638e6"
                it("should return success") {
                    var receivedLaptop: Laptop?
                    productsUseCase.fetchLaptop(
                        id: id,
                        completion: { result in
                            switch result {
                            case .success(let smartphone):
                                receivedLaptop = smartphone
                            case .failure:
                                fail("Expected call fetchLaptop(id:) to succeed, but it failed.")
                            }
                        }
                    )
                    expect(receivedLaptop?.id).toEventually(equal(id))
                }
            }
        }

        // MARK: - fetchLaptops(:)

        describe("on fetchLaptops(:)") {
            context("when repository fails") {
                it("should return error") {
                    productsUseCase = self.mockFailureUseCase()
                    var receivedError: Error?
                    productsUseCase.fetchLaptops(
                        completion: { result in
                            switch result {
                            case .success:
                                fail("Expected call fetchLaptops(:) to fail, but it succeed.")
                            case .failure(let error):
                                receivedError = error
                            }
                        }
                    )
                    expect(receivedError).toNotEventually(beNil())
                }
            }

            it("should return success") {
                var receivedLaptops: [Laptop]?
                productsUseCase.fetchLaptops(
                    completion: { result in
                        switch result {
                        case .success(let laptops):
                            receivedLaptops = laptops
                        case .failure:
                            fail("Expected call fetchLaptops(:) to succeed, but it failed.")
                        }
                    }
                )
                expect(receivedLaptops).toNotEventually(beEmpty())
            }
        }

        // MARK: - fetchTV(id:)

        describe("on fetchTV(id:)") {
            context("with wrong id") {
                it("should return error") {
                    var receivedError: Error?
                    productsUseCase.fetchTV(
                        id: "wrongId",
                        completion: { result in
                            switch result {
                            case .success:
                                fail("Expected call fetchTV(id:) to fail, but it succeed.")
                            case .failure(let error):
                                receivedError = error
                            }
                        }
                    )
                    expect(receivedError).toNotEventually(beNil())
                }
            }

            context("with correct id") {
                let id = "09af2b066b649bbb8ff54dafca4660fe"
                it("should return success") {
                    var receivedTV: TV?
                    productsUseCase.fetchTV(
                        id: id,
                        completion: { result in
                            switch result {
                            case .success(let tv):
                                receivedTV = tv
                            case .failure:
                                fail("Expected call fetchTV(id:) to succeed, but it failed.")
                            }
                        }
                    )
                    expect(receivedTV?.id).toEventually(equal(id))
                }
            }
        }

        // MARK: - fetchTVs(:)

        describe("on fetchTVs(:)") {
            context("when repository fails") {
                it("should return error") {
                    productsUseCase = self.mockFailureUseCase()
                    var receivedError: Error?
                    productsUseCase.fetchTVs(
                        completion: { result in
                            switch result {
                            case .success:
                                fail("Expected call fetchTVs(:) to fail, but it succeed.")
                            case .failure(let error):
                                receivedError = error
                            }
                        }
                    )
                    expect(receivedError).toNotEventually(beNil())
                }
            }

            it("should return success") {
                var receivedTVs: [TV]?
                productsUseCase.fetchTVs(
                    completion: { result in
                        switch result {
                        case .success(let tvs):
                            receivedTVs = tvs
                        case .failure:
                            fail("Expected call fetchTVs(:) to succeed, but it failed.")
                        }
                    }
                )
                expect(receivedTVs).toNotEventually(beEmpty())
            }
        }
    }
}

// MARK: - Utils
extension ProductsUseCaseSpec {
    func mockFailureUseCase() -> ProductsUseCase {
        let provider = MoyaProvider<eStore>(
            endpointClosure: ProductsUseCaseSpec.errorEndpointClosure,
            stubClosure: MoyaProvider.immediatelyStub
        )
        let repository = ProductsRepositoryImpl(provider: provider)
        return ProductsUseCaseImpl(repository: repository)
    }

    static func errorEndpointClosure(target: eStore) -> Endpoint {
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
