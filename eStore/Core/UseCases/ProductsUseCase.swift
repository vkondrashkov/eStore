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
    func fetchSmartphone(id: String, completion: @escaping (Result<Smartphone, ProductsUseCaseError>) -> Void)
    func fetchSmartphones(completion: @escaping (Result<[Smartphone], ProductsUseCaseError>) -> Void)
    func fetchLaptop(id: String, completion: @escaping (Result<Laptop, ProductsUseCaseError>) -> Void)
    func fetchLaptops(completion: @escaping (Result<[Laptop], ProductsUseCaseError>) -> Void)
    func fetchTV(id: String, completion: @escaping (Result<TV, ProductsUseCaseError>) -> Void)
    func fetchTVs(completion: @escaping (Result<[TV], ProductsUseCaseError>) -> Void)
}

final class ProductsUseCaseImpl: ProductsUseCase {
    private let repository: ProductsRepository

    init(repository: ProductsRepository) {
        self.repository = repository
    }

    func fetchSmartphone(id: String, completion: @escaping (Result<Smartphone, ProductsUseCaseError>) -> Void) {
        repository.fetchSmartphone(id: id) { result in
            switch result {
            case .success(let smartphone):
                completion(.success(smartphone))
            case .failure(let error):
                switch error {
                case .badRequest:
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
                case .badRequest:
                    completion(.failure(.invalidData))
                default:
                    completion(.failure(.failure))
                }
            }
        }
    }

    func fetchLaptop(id: String, completion: @escaping (Result<Laptop, ProductsUseCaseError>) -> Void) {
        repository.fetchLaptop(id: id) { result in
            switch result {
            case .success(let laptop):
                completion(.success(laptop))
            case .failure(let error):
                switch error {
                case .badRequest:
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
                case .badRequest:
                    completion(.failure(.invalidData))
                default:
                    completion(.failure(.failure))
                }
            }
        }
    }

    func fetchTV(id: String, completion: @escaping (Result<TV, ProductsUseCaseError>) -> Void) {
        repository.fetchTV(id: id) { result in
            switch result {
            case .success(let tv):
                completion(.success(tv))
            case .failure(let error):
                switch error {
                case .badRequest:
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
                case .badRequest:
                    completion(.failure(.invalidData))
                default:
                    completion(.failure(.failure))
                }
            }
        }
    }
}
