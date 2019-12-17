//
//  CartInteractor.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 12/17/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

final class CartInteractorImpl {
    private let cartRepository: CartRepository
    private let userRepository: UserRepository

    init(cartRepository: CartRepository,
         userRepository: UserRepository) {
        self.cartRepository = cartRepository
        self.userRepository = userRepository
    }
}

// MARK: - CartInteractor implementation

extension CartInteractorImpl: CartInteractor {
    func fetch(completion: @escaping (Result<[CartItem], CartInteractorError>) -> Void) {
        guard let user = userRepository.currentUser else {
            completion(.failure(.notAuthorized))
            return
        }
        cartRepository.fetchCart(userId: user.id, completion: { cartItems in
            let result: Result<[CartItem], CartInteractorError> = cartItems
                .mapError { _ in
                    return .failed
                }
            completion(result)
        })
    }

    func delete(storeItemId: Int, completion: @escaping (CartInteractorError?) -> Void) {
        guard let user = userRepository.currentUser else {
            completion(.notAuthorized)
            return
        }
        cartRepository.remove(
            userId: user.id,
            storeItemId: storeItemId,
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
