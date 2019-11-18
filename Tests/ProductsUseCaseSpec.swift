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
    final class CompletionSpy<V, E: Error> {
        var invoked = false
        var invokedResult: Result<V, E>?

        lazy var completion: (Result<V, E>) -> Void = { result in
            self.invoked = true
            self.invokedResult = result
        }
    }

    override func spec() {
        var productsUseCase: ProductsUseCase!

        // MARK: - When repository succeeds

        context("when repository succeeds") {
            beforeEach {
                let provider = MoyaProvider<eStoreAPI>(stubClosure: MoyaProvider.immediatelyStub)
                let repository = ProductsRepositoryImpl(provider: provider)
                productsUseCase = ProductsUseCaseImpl(repository: repository)
            }

            // MARK: - Smartphone requests

            describe("on fetchSmartphone(id:)") {
                context("with wrong id") {
                    it("should return error") {
                        let completionSpy = CompletionSpy<Smartphone, ProductsUseCaseError>()
                        productsUseCase.fetchSmartphone(
                            id: "wrongId",
                            completion: completionSpy.completion
                        )
                        expect(completionSpy.invokedResult?.error).toNot(beNil())
                    }
                }

                context("with correct id") {
                    let id = "3571539fcbe330452d4d938502ed9f15"
                    it("should return success") {
                        let completionSpy = CompletionSpy<Smartphone, ProductsUseCaseError>()
                        productsUseCase.fetchSmartphone(
                            id: id,
                            completion: completionSpy.completion
                        )
                        expect(completionSpy.invokedResult?.value?.id).to(equal(id))
                    }
                }
            }

            describe("on fetchSmarphones(:)") {
                it("should return success") {
                    let completionSpy = CompletionSpy<[Smartphone], ProductsUseCaseError>()
                    productsUseCase.fetchSmartphones(
                        completion: completionSpy.completion
                    )
                    expect(completionSpy.invokedResult?.value).toNot(beEmpty())
                }
            }

            // MARK: - Laptop requests

            describe("on fetchLaptop(id:)") {
                context("with wrong id") {
                    it("should return error") {
                        let completionSpy = CompletionSpy<Laptop, ProductsUseCaseError>()
                        productsUseCase.fetchLaptop(
                            id: "wrongId",
                            completion: completionSpy.completion
                        )
                        expect(completionSpy.invokedResult?.error).toNot(beNil())
                    }
                }

                context("with correct id") {
                    let id = "34ec91a46a12a40fc44c414b61b638e6"
                    it("should return success") {
                        let completionSpy = CompletionSpy<Laptop, ProductsUseCaseError>()
                        productsUseCase.fetchLaptop(
                            id: id,
                            completion: completionSpy.completion
                        )
                        expect(completionSpy.invokedResult?.value?.id).to(equal(id))
                    }
                }
            }

            describe("on fetchLaptops(:)") {
                it("should return success") {
                    let completionSpy = CompletionSpy<[Laptop], ProductsUseCaseError>()
                    productsUseCase.fetchLaptops(
                        completion: completionSpy.completion
                    )
                    expect(completionSpy.invokedResult?.value).toNot(beEmpty())
                }
            }

            // MARK: - TV requests

            describe("on fetchTV(id:)") {
                context("with wrong id") {
                    it("should return error") {
                        let completionSpy = CompletionSpy<TV, ProductsUseCaseError>()
                        productsUseCase.fetchTV(
                            id: "wrongId",
                            completion: completionSpy.completion
                        )
                        expect(completionSpy.invokedResult?.error).toNot(beNil())
                    }
                }

                context("with correct id") {
                    let id = "09af2b066b649bbb8ff54dafca4660fe"
                    it("should return success") {
                        let completionSpy = CompletionSpy<TV, ProductsUseCaseError>()
                        productsUseCase.fetchTV(
                            id: id,
                            completion: completionSpy.completion
                        )
                        expect(completionSpy.invokedResult?.value?.id).to(equal(id))
                    }
                }
            }

            describe("on fetchTVs(:)") {
                it("should return success") {
                    let completionSpy = CompletionSpy<[TV], ProductsUseCaseError>()
                    productsUseCase.fetchTVs(
                        completion: completionSpy.completion
                    )
                    expect(completionSpy.invokedResult?.value).toNot(beEmpty())
                }
            }
        }

        // MARK: - When repository fails

        context("when repository fails") {
            beforeEach {
                let provider = MoyaProvider<eStoreAPI>(
                    endpointClosure: ProductsUseCaseSpec.errorEndpointClosure,
                    stubClosure: MoyaProvider.immediatelyStub
                )
                let repository = ProductsRepositoryImpl(provider: provider)
                productsUseCase = ProductsUseCaseImpl(repository: repository)
            }

            describe("on fetchSmartphones(:)") {
                it("should return error") {
                    let completionSpy = CompletionSpy<[Smartphone], ProductsUseCaseError>()
                    productsUseCase.fetchSmartphones(
                        completion: completionSpy.completion
                    )
                    expect(completionSpy.invokedResult?.error).toNot(beNil())
                }
            }

            describe("on fetchLaptop(:)") {
                it("should return error") {
                    let completionSpy = CompletionSpy<[Laptop], ProductsUseCaseError>()
                    productsUseCase.fetchLaptops(
                        completion: completionSpy.completion
                    )
                    expect(completionSpy.invokedResult?.error).toNot(beNil())
                }
            }

            describe("on fetchTVs(:)") {
                it("should return error") {
                    let completionSpy = CompletionSpy<[TV], ProductsUseCaseError>()
                    productsUseCase.fetchTVs(
                        completion: completionSpy.completion
                    )
                    expect(completionSpy.invokedResult?.error).toNot(beNil())
                }
            }
        }
    }
}

// MARK: - Utils
extension ProductsUseCaseSpec {
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
