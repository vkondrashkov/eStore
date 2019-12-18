//
//  TVEditorInteractor.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 12/17/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

final class TVEditorInteractorImpl {
    private let userRepository: UserRepository
    private let productsUseCase: ProductsUseCase

    init(userRepository: UserRepository,
         productsUseCase: ProductsUseCase) {
        self.userRepository = userRepository
        self.productsUseCase = productsUseCase
    }
}

// MARK: - TVEditorInteractor implementation

extension TVEditorInteractorImpl: TVEditorInteractor {
    var currentUser: User? {
        return userRepository.currentUser
    }

    func addTV(tvForm: TVForm,
               completion: @escaping (Result<TV, TVEditorInteractorError>) -> Void) {
        guard let user = userRepository.currentUser else {
            completion(.failure(.notAuthorized))
            return
        }
        productsUseCase.addTV(
            userId: user.id,
            tvForm: tvForm,
            completion: { tv in
                let result: Result<TV, TVEditorInteractorError> = tv
                    .mapError { _ in
                        return .failed
                }
                completion(result)
            }
        )
    }
}
