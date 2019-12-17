//
//  LaptopEditorInteractor.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 12/17/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

final class LaptopEditorInteractorImpl {
    private let userRepository: UserRepository
    private let productsUseCase: ProductsUseCase

    init(userRepository: UserRepository,
         productsUseCase: ProductsUseCase) {
        self.userRepository = userRepository
        self.productsUseCase = productsUseCase
    }
}

// MARK: - LaptopEditorInteractor implementation

extension LaptopEditorInteractorImpl: LaptopEditorInteractor {
    var currentUser: User? {
        return userRepository.currentUser
    }

    func addLaptop(laptopForm: LaptopForm,
                   completion: @escaping (Result<Laptop, LaptopEditorInteractorError>) -> Void) {
        guard let user = userRepository.currentUser else {
            completion(.failure(.notAuthorized))
            return
        }
        productsUseCase.addLaptop(
            userId: user.id,
            laptopForm: laptopForm,
            completion: { laptop in
                let result: Result<Laptop, LaptopEditorInteractorError> = laptop
                    .mapError { _ in
                        return .failed
                }
                completion(result)
            }
        )
    }
}
