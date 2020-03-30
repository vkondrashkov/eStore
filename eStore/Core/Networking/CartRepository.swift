//
//  CartRepository.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 12/17/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import Moya
import ObjectMapper

enum CartRepositoryError: Error {
    case failed
    case invalidData
}

protocol CartRepository {
    func fetchCart(userId: Int, completion: @escaping (Result<[CartItem], CartRepositoryError>) -> Void)
    func add(userId: Int,
             productId: Int,
             productTypeId: Int,
             completion: @escaping (CartRepositoryError?) -> Void)
    func remove(userId: Int,
                storeItemId: Int,
                completion: @escaping (CartRepositoryError?) -> Void)
}

final class CartRepositoryImpl {
    private let provider: MoyaProvider<eStoreAPI>

    init(provider: MoyaProvider<eStoreAPI>) {
        self.provider = provider
    }
}

// MARK: - CartRepository implementation

extension CartRepositoryImpl: CartRepository {
    func fetchCart(userId: Int, completion: @escaping (Result<[CartItem], CartRepositoryError>) -> Void) {
        provider.request(.cart(userId: userId), completion: { result in
            switch result {
            case .success(let response):
                guard let json = try? response.mapJSON() as? [[String: Any]] else {
                    completion(.failure(.failed))
                    return
                }
                guard let itemList = try? Mapper<CartItem>().mapArray(JSONArray: json) else {
                    completion(.failure(.failed))
                    return
                }
                completion(.success(itemList))
            case .failure(let error):
                debugPrint("🛑 Error code: \(error.errorCode)\n\(error.errorDescription ?? "")")
                completion(.failure(.invalidData))
            }
        })
    }

    func add(userId: Int,
             productId: Int,
             productTypeId: Int,
             completion: @escaping (CartRepositoryError?) -> Void) {
        provider.request(
            .addCart(userId: userId, productId: productId, productTypeId: productTypeId),
            completion: { result in
                guard result.error == nil else {
                    completion(.failed)
                    return
                }
                completion(nil)
            }
        )
    }

    func remove(userId: Int,
                storeItemId: Int,
                completion: @escaping (CartRepositoryError?) -> Void) {
        provider.request(
            .deleteCart(userId: userId, cartItemId: storeItemId),
            completion: { result in
                guard result.error == nil else {
                    completion(.failed)
                    return
                }
                completion(nil)
            }
        )
    }
}
