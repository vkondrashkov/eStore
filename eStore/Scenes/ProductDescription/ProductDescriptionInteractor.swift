//
//  ProductDescriptionInteractor.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 12/17/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

final class ProductDescriptionInteractorImpl {
    private let cartRepository: CartRepository
    private let userRepository: UserRepository
    private let productsUseCase: ProductsUseCase

    init(cartRepository: CartRepository,
         userRepository: UserRepository,
         productsUseCase: ProductsUseCase) {
        self.cartRepository = cartRepository
        self.userRepository = userRepository
        self.productsUseCase = productsUseCase
    }
}

// MARK: - ProductDescriptionInteractor implementation

extension ProductDescriptionInteractorImpl: ProductDescriptionInteractor {
    var currentUser: User? {
        return userRepository.currentUser
    }

    func addToCart(productId: Int, productTypeId: Int, completion: @escaping (ProductDescriptionInteractorError?) -> Void) {
        guard let user = userRepository.currentUser else {
            completion(.notAuthorized)
            return
        }
        self.cartRepository.add(
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

    func fetchSmartphone(id: String, completion: @escaping (Result<Smartphone, ProductDescriptionInteractorError>) -> Void) {
        productsUseCase.fetchSmartphone(id: id, completion: { smartphone in
            let result: Result<Smartphone, ProductDescriptionInteractorError> = smartphone
                .mapError { _ in
                    return .failed
                }
            completion(result)
        })
    }

    func fetchLaptop(id: String, completion: @escaping (Result<Laptop, ProductDescriptionInteractorError>) -> Void) {
        productsUseCase.fetchLaptop(id: id, completion: { laptop in
            let result: Result<Laptop, ProductDescriptionInteractorError> = laptop
                .mapError { _ in
                    return .failed
                }
            completion(result)
        })
    }

    func fetchTV(id: String, completion: @escaping (Result<TV, ProductDescriptionInteractorError>) -> Void) {
        productsUseCase.fetchTV(id: id, completion: { tv in
            let result: Result<TV, ProductDescriptionInteractorError> = tv
                .mapError { _ in
                    return .failed
                }
            completion(result)
        })
    }
}
