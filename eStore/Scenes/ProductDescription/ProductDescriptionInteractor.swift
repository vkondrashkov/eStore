//
//  ProductDescriptionInteractor.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 12/17/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

final class ProductDescriptionInteractorImpl {
    private let cartRepository: CartRepository

    init(cartRepository: CartRepository) {
        self.cartRepository = cartRepository
    }
}

// MARK: - ProductDescriptionInteractor implementation

extension ProductDescriptionInteractorImpl: ProductDescriptionInteractor {
    func addToCart(id: Int, productTypeId: Int, completion: @escaping (ProductDescriptionInteractorError?) -> Void) {
        cartRepository.add(id: id, productTypeId: productTypeId, completion: { error in
            guard error == nil else {
                completion(.failed)
                return
            }
            completion(nil)
        })
    }
}
