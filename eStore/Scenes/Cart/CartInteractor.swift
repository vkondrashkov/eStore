//
//  CartInteractor.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 12/17/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

final class CartInteractorImpl {
    private let cartRepository: CartRepository

    init(cartRepository: CartRepository) {
        self.cartRepository = cartRepository
    }
}

// MARK: - CartInteractor implementation

extension CartInteractorImpl: CartInteractor {
    func fetch(completion: @escaping (Result<[CartItem], CartInteractorError>) -> Void) {
        cartRepository.fetch(completion: { cartItems in
            let result: Result<[CartItem], CartInteractorError> = cartItems
                .mapError { _ in
                    return .failed
                }
            completion(result)
        })
    }
}
