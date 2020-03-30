//
//  ProductsListInteractor.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 12/16/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

final class ProductsListInteractorImpl {
    private let productsUseCase: ProductsUseCase
    private let userRepository: UserRepository
    private let cartRepository: CartRepository

    init(productsUseCase: ProductsUseCase,
         userRepository: UserRepository,
         cartRepository: CartRepository) {
        self.productsUseCase = productsUseCase
        self.userRepository = userRepository
        self.cartRepository = cartRepository
    }
}

// MARK: - ProductsListInteractor implementation

extension ProductsListInteractorImpl: ProductsListInteractor {
    var currentUser: User? {
        return userRepository.currentUser
    }

    func fetchSmartphones(completion: @escaping (Result<[Smartphone], ProductsListInteractorError>) -> Void) {
        productsUseCase.fetchSmartphones(completion: { smartphones in
            let result: Result<[Smartphone], ProductsListInteractorError> = smartphones.mapError { _ in
                return .failed
            }
            completion(result)
        })
    }

    func deleteSmartphone(id: Int, completion: @escaping (ProductsListInteractorError?) -> Void) {
        productsUseCase.deleteSmartphone(id: id, completion: { error in
            guard error == nil else {
                completion(.failed)
                return
            }
            completion(nil)
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

    func deleteTV(id: Int, completion: @escaping (ProductsListInteractorError?) -> Void) {
        productsUseCase.deleteTV(id: id, completion: { error in
            guard error == nil else {
                completion(.failed)
                return
            }
            completion(nil)
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

    func deleteLaptop(id: Int, completion: @escaping (ProductsListInteractorError?) -> Void) {
        productsUseCase.deleteLaptop(id: id, completion: { error in
            guard error == nil else {
                completion(.failed)
                return
            }
            completion(nil)
        })
    }

    func addToCart(productId: Int,
                   productTypeId: Int,
                   completion: @escaping (ProductsListInteractorError?) -> Void) {
        guard let user = userRepository.currentUser else {
            completion(.notAuthorized)
            return
        }
        cartRepository.add(
            userId: user.id,
            productId: productId,
            productTypeId: productTypeId,
            completion: { error in
                guard error == nil else {
                    completion(.failed)
                    return
                }
                completion(nil)
            }
        )
    }
}
