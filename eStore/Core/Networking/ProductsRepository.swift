//
//  ProductsRepository.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 11/17/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import Moya
import ObjectMapper

enum ProductsRepositoryError: Error {
    case invalidInput
    case failed
}

protocol ProductsRepository {
    func addSmartphone(userId: Int,
                       smartphoneForm: SmartphoneForm,
                       completion: @escaping (Result<Smartphone, ProductsRepositoryError>) -> Void)
    func updateSmartphone(userId: Int,
                          smartphoneId: Int,
                          smartphoneForm: SmartphoneForm,
                          completion: @escaping (Result<Smartphone, ProductsRepositoryError>) -> Void)
    func fetchSmartphones(completion: @escaping (Result<[Smartphone], ProductsRepositoryError>) -> Void)
    func fetchSmartphone(id: String, completion: @escaping (Result<Smartphone, ProductsRepositoryError>) -> Void)
    func deleteSmartphone(id: Int, completion: @escaping (ProductsRepositoryError?) -> Void)
    func addLaptop(userId: Int,
                   laptopForm: LaptopForm,
                   completion: @escaping (Result<Laptop, ProductsRepositoryError>) -> Void)
    func updateLaptop(userId: Int,
                      laptopId: Int,
                      laptopForm: LaptopForm,
                      completion: @escaping (Result<Laptop, ProductsRepositoryError>) -> Void)
    func fetchLaptops(completion: @escaping (Result<[Laptop], ProductsRepositoryError>) -> Void)
    func fetchLaptop(id: String, completion: @escaping (Result<Laptop, ProductsRepositoryError>) -> Void)
    func deleteLaptop(id: Int, completion: @escaping (ProductsRepositoryError?) -> Void)
    func addTV(userId: Int,
               tvForm: TVForm,
               completion: @escaping (Result<TV, ProductsRepositoryError>) -> Void)
    func updateTV(userId: Int,
                  tvId: Int,
                  tvForm: TVForm,
                  completion: @escaping (Result<TV, ProductsRepositoryError>) -> Void)
    func fetchTVs(completion: @escaping (Result<[TV], ProductsRepositoryError>) -> Void)
    func fetchTV(id: String, completion: @escaping (Result<TV, ProductsRepositoryError>) -> Void)
    func deleteTV(id: Int, completion: @escaping (ProductsRepositoryError?) -> Void)
}

final class ProductsRepositoryImpl {
    private let provider: MoyaProvider<eStoreAPI>

    init(provider: MoyaProvider<eStoreAPI>) {
        self.provider = provider
    }
}

// MARK: - ProductsRepository implementation
extension ProductsRepositoryImpl: ProductsRepository {
    func updateSmartphone(userId: Int,
                          smartphoneId: Int,
                          smartphoneForm: SmartphoneForm,
                          completion: @escaping (Result<Smartphone, ProductsRepositoryError>) -> Void) {
        provider.request(.updateSmartphone(
            userId: userId,
            smartphoneId: smartphoneId,
            smartphoneForm: smartphoneForm)) { result in
                completion(self.processResponse(result: result))
        }
    }

    func addSmartphone(userId: Int,
                       smartphoneForm: SmartphoneForm,
                       completion: @escaping (Result<Smartphone, ProductsRepositoryError>) -> Void) {
        provider.request(.addSmartphone(userId: userId, smartphoneForm: smartphoneForm)) { result in
            completion(self.processResponse(result: result))
        }
    }

    func fetchSmartphones(completion: @escaping (Result<[Smartphone], ProductsRepositoryError>) -> Void) {
        provider.request(.smartphones) { result in
            completion(self.processResponse(result: result))
        }
    }

    func fetchSmartphone(id: String, completion: @escaping (Result<Smartphone, ProductsRepositoryError>) -> Void) {
        provider.request(.smartphone(id: id)) { result in
            completion(self.processResponse(result: result))
        }
    }

    func deleteSmartphone(id: Int, completion: @escaping (ProductsRepositoryError?) -> Void) {
        provider.request(.deleteSmartphone(id: id)) { result in
            guard result.error == nil else {
                completion(.failed)
                return
            }
            completion(nil)
        }
    }

    func addLaptop(userId: Int,
                   laptopForm: LaptopForm,
                   completion: @escaping (Result<Laptop, ProductsRepositoryError>) -> Void) {
        provider.request(.addLaptop(userId: userId, laptopForm: laptopForm)) { result in
            completion(self.processResponse(result: result))
        }
    }

    func updateLaptop(userId: Int,
                      laptopId: Int,
                      laptopForm: LaptopForm,
                      completion: @escaping (Result<Laptop, ProductsRepositoryError>) -> Void) {
        provider.request(.updateLaptop(
            userId: userId,
            laptopId: laptopId,
            laptopForm: laptopForm)) { result in
                completion(self.processResponse(result: result))
        }
    }

    func fetchLaptops(completion: @escaping (Result<[Laptop], ProductsRepositoryError>) -> Void) {
        provider.request(.laptops) { result in
            completion(self.processResponse(result: result))
        }
    }

    func fetchLaptop(id: String, completion: @escaping (Result<Laptop, ProductsRepositoryError>) -> Void) {
        provider.request(.laptop(id: id)) { result in
            completion(self.processResponse(result: result))
        }
    }

    func deleteLaptop(id: Int, completion: @escaping (ProductsRepositoryError?) -> Void) {
        provider.request(.deleteLaptop(id: id)) { result in
            guard result.error == nil else {
                completion(.failed)
                return
            }
            completion(nil)
        }
    }

    func addTV(userId: Int,
               tvForm: TVForm,
               completion: @escaping (Result<TV, ProductsRepositoryError>) -> Void) {
        provider.request(.addTV(userId: userId, tvForm: tvForm)) { result in
            completion(self.processResponse(result: result))
        }
    }

    func updateTV(userId: Int,
                  tvId: Int,
                  tvForm: TVForm,
                  completion: @escaping (Result<TV, ProductsRepositoryError>) -> Void) {
        provider.request(.updateTV(
            userId: userId,
            tvId: tvId,
            tvForm: tvForm)) { result in
                completion(self.processResponse(result: result))
        }
    }

    func fetchTVs(completion: @escaping (Result<[TV], ProductsRepositoryError>) -> Void) {
        provider.request(.tvs) { result in
            completion(self.processResponse(result: result))
        }
    }

    func fetchTV(id: String, completion: @escaping (Result<TV, ProductsRepositoryError>) -> Void) {
        provider.request(.tv(id: id)) { result in
            completion(self.processResponse(result: result))
        }
    }

    func deleteTV(id: Int, completion: @escaping (ProductsRepositoryError?) -> Void) {
        provider.request(.deleteTV(id: id)) { result in
            guard result.error == nil else {
                completion(.failed)
                return
            }
            completion(nil)
        }
    }
}

// MARK: - Utils
private extension ProductsRepositoryImpl {
    typealias MoyaResult = Result<Response, MoyaError>
    typealias ItemResult<Item> = Result<Item, ProductsRepositoryError>

    func processResponse<Item: ImmutableMappable>(result: MoyaResult) -> ItemResult<Item> {
        switch result {
        case .success(let response):
            guard let json = try? response.mapJSON() as? [String: Any] else {
                return .failure(.failed)
            }
            guard let item = Mapper<Item>().map(JSON: json) else {
                return .failure(.failed)
            }
            return .success(item)
        case .failure(let error):
            debugPrint("🛑 Error code: \(error.errorCode)\n\(error.errorDescription ?? "")")
            return .failure(.invalidInput)
        }
    }

    func processResponse<Item: ImmutableMappable>(result: MoyaResult) -> ItemResult<[Item]> {
        switch result {
        case .success(let response):
            guard let json = try? response.mapJSON() as? [[String: Any]] else {
                return .failure(.failed)
            }
            guard let itemList = try? Mapper<Item>().mapArray(JSONArray: json) else {
                return .failure(.failed)
            }
            return .success(itemList)
        case .failure(let error):
            debugPrint("🛑 Error code: \(error.errorCode)\n\(error.errorDescription ?? "")")
            return .failure(.invalidInput)
        }
    }
}
