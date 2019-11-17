//
//  ProductsRepository.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 11/17/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper
import Result

enum ProductsRepositoryError: Error {
    case badRequest
    case badResponse
}

protocol ProductsRepository {
    func fetchSmartphones(completion: @escaping (Result<[Smartphone], ProductsRepositoryError>) -> Void)
    func fetchSmartphone(id: String, completion: @escaping (Result<Smartphone, ProductsRepositoryError>) -> Void)
    func fetchLaptops(completion: @escaping (Result<[Laptop], ProductsRepositoryError>) -> Void)
    func fetchLaptop(id: String, completion: @escaping (Result<Laptop, ProductsRepositoryError>) -> Void)
    func fetchTVs(completion: @escaping (Result<[TV], ProductsRepositoryError>) -> Void)
    func fetchTV(id: String, completion: @escaping (Result<TV, ProductsRepositoryError>) -> Void)
}

final class ProductsRepositoryImpl {
    private let provider: MoyaProvider<eStore>

    init(provider: MoyaProvider<eStore>) {
        self.provider = provider
    }
}

// MARK: - ProductsRepository implementation
extension ProductsRepositoryImpl: ProductsRepository {
    func fetchSmartphones(completion: @escaping (Result<[Smartphone], ProductsRepositoryError>) -> Void) {
        provider.request(.getSmartphones) { result in
            completion(self.processResponse(result: result))
        }
    }

    func fetchSmartphone(id: String, completion: @escaping (Result<Smartphone, ProductsRepositoryError>) -> Void) {
        provider.request(.getSmartphone(id)) { result in
            completion(self.processResponse(result: result))
        }
    }

    func fetchLaptops(completion: @escaping (Result<[Laptop], ProductsRepositoryError>) -> Void) {
        provider.request(.getLaptops) { result in
            completion(self.processResponse(result: result))
        }
    }

    func fetchLaptop(id: String, completion: @escaping (Result<Laptop, ProductsRepositoryError>) -> Void) {
        provider.request(.getLaptop(id)) { result in
            completion(self.processResponse(result: result))
        }
    }

    func fetchTVs(completion: @escaping (Result<[TV], ProductsRepositoryError>) -> Void) {
        provider.request(.getTVs) { result in
            completion(self.processResponse(result: result))
        }
    }

    func fetchTV(id: String, completion: @escaping (Result<TV, ProductsRepositoryError>) -> Void) {
        provider.request(.getTV(id)) { result in
            completion(self.processResponse(result: result))
        }
    }
}

private extension ProductsRepositoryImpl {
    typealias MoyaResult = Result<Response, MoyaError>
    typealias ItemResult<Item> = Result<Item, ProductsRepositoryError>

    func processResponse<Item: ImmutableMappable>(result: MoyaResult) -> ItemResult<Item> {
        switch result {
        case .success(let response):
            guard let json = try? response.mapJSON() as? [String: Any] else {
                return .failure(.badResponse)
            }
            guard let item = Mapper<Item>().map(JSON: json) else {
                return .failure(.badResponse)
            }
            return .success(item)
        case .failure(let error):
            debugPrint("🛑 Error code: \(error.errorCode)\n\(error.errorDescription ?? "")")
            return .failure(.badRequest)
        }
    }

    func processResponse<Item: ImmutableMappable>(result: MoyaResult) -> ItemResult<[Item]> {
        switch result {
        case .success(let response):
            guard let json = try? response.mapJSON() as? [[String: Any]] else {
                return .failure(.badResponse)
            }
            guard let itemList = try? Mapper<Item>().mapArray(JSONArray: json) else {
                return .failure(.badResponse)
            }
            return .success(itemList)
        case .failure(let error):
            debugPrint("🛑 Error code: \(error.errorCode)\n\(error.errorDescription ?? "")")
            return .failure(.badRequest)
        }
    }
}
