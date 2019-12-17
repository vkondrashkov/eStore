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

    init(cartRepository: CartRepository,
         userRepository: UserRepository) {
        self.cartRepository = cartRepository
        self.userRepository = userRepository
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
}
