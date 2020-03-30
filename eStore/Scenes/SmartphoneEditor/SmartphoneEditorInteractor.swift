//
//  SmartphoneEditorInteractor.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 12/17/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

final class SmartphoneEditorInteractorImpl {
    private let userRepository: UserRepository
    private let productsUseCase: ProductsUseCase

    init(userRepository: UserRepository,
         productsUseCase: ProductsUseCase) {
        self.userRepository = userRepository
        self.productsUseCase = productsUseCase
    }
}

// MARK: - SmartphoneEditorInteractor implementation

extension SmartphoneEditorInteractorImpl: SmartphoneEditorInteractor {
    var currentUser: User? {
        return userRepository.currentUser
    }

    func addSmartphone(smartphoneForm: SmartphoneForm,
                       completion: @escaping (Result<Smartphone, SmartphoneEditorInteractorError>) -> Void) {
        guard let user = userRepository.currentUser else {
            completion(.failure(.notAuthorized))
            return
        }
        productsUseCase.addSmartphone(
            userId: user.id,
            smartphoneForm: smartphoneForm,
            completion: { smartphone in
                let result: Result<Smartphone, SmartphoneEditorInteractorError> = smartphone
                    .mapError { _ in
                        return .failed
                    }
                completion(result)
            }
        )
    }

    func updateSmartphone(smartphoneId: Int,
                          smartphoneForm: SmartphoneForm,
                          completion: @escaping (Result<Smartphone, SmartphoneEditorInteractorError>) -> Void) {
        guard let user = userRepository.currentUser else {
            completion(.failure(.notAuthorized))
            return
        }
        productsUseCase.updateSmartphone(
            userId: user.id,
            smartphoneId: smartphoneId,
            smartphoneForm: smartphoneForm,
            completion: { smartphone in
                let result: Result<Smartphone, SmartphoneEditorInteractorError> = smartphone
                    .mapError { _ in
                        return .failed
                    }
                completion(result)
            }
        )
    }
}
