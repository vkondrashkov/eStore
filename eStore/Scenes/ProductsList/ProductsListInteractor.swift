//
//  ProductsListInteractor.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 12/16/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

final class ProductsListInteractorImpl {
    private let productsUseCase: ProductsUseCase

    init(productsUseCase: ProductsUseCase) {
        self.productsUseCase = productsUseCase
    }
}

// MARK: - ProductsListInteractor implementation

extension ProductsListInteractorImpl: ProductsListInteractor {
    func fetchSmartphones(completion: @escaping (Result<[Smartphone], ProductsListInteractorError>) -> Void) {
        productsUseCase.fetchSmartphones(completion: { smartphones in
            let result: Result<[Smartphone], ProductsListInteractorError> = smartphones.mapError { _ in
                return .failed
            }
            completion(result)
        })
    }

    func fetchTVs(completion: @escaping (Result<[TV], ProductsListInteractorError>) -> Void) {
        productsUseCase.fetchTVs(completion: { tvs in
            let result: Result<[TV], ProductsListInteractorError> = tvs.mapError { _ in
                return .failed
            }
            completion(result)
        })
    }

    func fetchLaptops(completion: @escaping (Result<[Laptop], ProductsListInteractorError>) -> Void) {
        productsUseCase.fetchLaptops(completion: { laptops in
            let result: Result<[Laptop], ProductsListInteractorError> = laptops.mapError { _ in
                return .failed
            }
            completion(result)
        })
    }
}
