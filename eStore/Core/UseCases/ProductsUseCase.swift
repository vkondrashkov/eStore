//
//  ProductsUseCase.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 11/16/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import Foundation

enum ProductsUseCaseError: Error {
    case invalidData
    case failure
}

protocol ProductsUseCase {
    func addSmartphone(userId: Int,
                       smartphoneForm: SmartphoneForm,
                       completion: @escaping (Result<Smartphone, ProductsRepositoryError>) -> Void)
    func fetchSmartphone(id: String, completion: @escaping (Result<Smartphone, ProductsUseCaseError>) -> Void)
    func fetchSmartphones(completion: @escaping (Result<[Smartphone], ProductsUseCaseError>) -> Void)
    func deleteSmartphone(id: Int, completion: @escaping (ProductsUseCaseError?) -> Void)
    func addLaptop(userId: Int,
                   laptopForm: LaptopForm,
                   completion: @escaping (Result<Laptop, ProductsRepositoryError>) -> Void)
    func fetchLaptop(id: String, completion: @escaping (Result<Laptop, ProductsUseCaseError>) -> Void)
    func fetchLaptops(completion: @escaping (Result<[Laptop], ProductsUseCaseError>) -> Void)
    func deleteLaptop(id: Int, completion: @escaping (ProductsUseCaseError?) -> Void)
    func fetchTV(id: String, completion: @escaping (Result<TV, ProductsUseCaseError>) -> Void)
    func fetchTVs(completion: @escaping (Result<[TV], ProductsUseCaseError>) -> Void)
    func deleteTV(id: Int, completion: @escaping (ProductsUseCaseError?) -> Void)
}

final class ProductsUseCaseImpl: ProductsUseCase {
    private let repository: ProductsRepository

    init(repository: ProductsRepository) {
        self.repository = repository
    }

    func addSmartphone(userId: Int,
                       smartphoneForm: SmartphoneForm,
                       completion: @escaping (Result<Smartphone, ProductsRepositoryError>) -> Void) {
        repository.addSmartphone(
            userId: userId,
            smartphoneForm: smartphoneForm,
            completion: { smartphone in
                let result: Result<Smartphone, ProductsRepositoryError> = smartphone
                    .mapError { _ in
                        return .failed
                    }
                completion(result)
            }
        )
    }

    func fetchSmartphone(id: String, completion: @escaping (Result<Smartphone, ProductsUseCaseError>) -> Void) {
        repository.fetchSmartphone(id: id) { result in
            switch result {
            case .success(let smartphone):
                completion(.success(smartphone))
            case .failure(let error):
                switch error {
                case .invalidInput:
                    completion(.failure(.invalidData))
                default:
                    completion(.failure(.failure))
                }
            }
        }
    }

    func fetchSmartphones(completion: @escaping (Result<[Smartphone], ProductsUseCaseError>) -> Void) {
        repository.fetchSmartphones { result in
            switch result {
            case .success(let smartphones):
                completion(.success(smartphones))
            case .failure(let error):
                switch error {
                case .invalidInput:
                    completion(.failure(.invalidData))
                default:
                    completion(.failure(.failure))
                }
            }
        }
    }

    func deleteSmartphone(id: Int, completion: @escaping (ProductsUseCaseError?) -> Void) {
        repository.deleteSmartphone(id: id, completion: { error in
            guard error == nil else {
                completion(.failure)
                return
            }
            completion(nil)
        })
    }

    func addLaptop(userId: Int,
                   laptopForm: LaptopForm,
                   completion: @escaping (Result<Laptop, ProductsRepositoryError>) -> Void) {
        repository.addLaptop(
            userId: userId,
            laptopForm: laptopForm,
            completion: { laptop in
                let result: Result<Laptop, ProductsRepositoryError> = laptop
                    .mapError { _ in
                        return .failed
                    }
                completion(result)
            }
        )
    }

    func fetchLaptop(id: String, completion: @escaping (Result<Laptop, ProductsUseCaseError>) -> Void) {
        repository.fetchLaptop(id: id) { result in
            switch result {
            case .success(let laptop):
                completion(.success(laptop))
            case .failure(let error):
                switch error {
                case .invalidInput:
                    completion(.failure(.invalidData))
                default:
                    completion(.failure(.failure))
                }
            }
        }
    }

    func fetchLaptops(completion: @escaping (Result<[Laptop], ProductsUseCaseError>) -> Void) {
        repository.fetchLaptops { result in
            switch result {
            case .success(let laptops):
                completion(.success(laptops))
            case .failure(let error):
                switch error {
                case .invalidInput:
                    completion(.failure(.invalidData))
                default:
                    completion(.failure(.failure))
                }
            }
        }
    }

    func deleteLaptop(id: Int, completion: @escaping (ProductsUseCaseError?) -> Void) {
        repository.deleteLaptop(id: id, completion: { error in
            guard error == nil else {
                completion(.failure)
                return
            }
            completion(nil)
        })
    }

    func fetchTV(id: String, completion: @escaping (Result<TV, ProductsUseCaseError>) -> Void) {
        repository.fetchTV(id: id) { result in
            switch result {
            case .success(let tv):
                completion(.success(tv))
            case .failure(let error):
                switch error {
                case .invalidInput:
                    completion(.failure(.invalidData))
                default:
                    completion(.failure(.failure))
                }
            }
        }
    }

    func fetchTVs(completion: @escaping (Result<[TV], ProductsUseCaseError>) -> Void) {
        repository.fetchTVs { result in
            switch result {
            case .success(let tvs):
                completion(.success(tvs))
            case .failure(let error):
                switch error {
                case .invalidInput:
                    completion(.failure(.invalidData))
                default:
                    completion(.failure(.failure))
                }
            }
        }
    }

    func deleteTV(id: Int, completion: @escaping (ProductsUseCaseError?) -> Void) {
        repository.deleteTV(id: id, completion: { error in
            guard error == nil else {
                return
            }
            completion(nil)
        })
    }
}
