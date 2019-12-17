//
//  eStoreAPI.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 11/17/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import Alamofire
import Moya

enum eStoreAPI {
    case authorize(login: String, password: String)

    case smartphones
    case smartphone(id: String)
    case deleteSmartphone(id: String)

    case laptops
    case laptop(id: String)
    case deleteLaptop(id: String)

    case tvs
    case tv(id: String)
    case deleteTV(id: String)

    case cart
    case addCart(id: Int, productId: Int)
    case deleteCart(id: Int)
}

// MARK: TargetType implementation
extension eStoreAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://localhost:8080")!
        //return URL(string: "http://192.168.0.100:8080")!
    }

    var path: String {
        switch self {
        case .authorize:
            return "/authorize"
        case .smartphones:
            return "/smartphone"
        case .smartphone(let id):
            return "/smartphone/\(id)"
        case .deleteSmartphone(let id):
            return "/smartphone/\(id)"
        case .laptops:
            return "/laptop"
        case .laptop(let id):
            return "/laptop/\(id)"
        case .deleteLaptop(let id):
            return "/laptop/\(id)"
        case .tvs:
            return "/tv"
        case .tv(let id):
            return "/tv/\(id)"
        case .deleteTV(let id):
            return "/tv/\(id)"
        case .cart:
            return "/cart"
        case .addCart:
            return "/cart"
        case .deleteCart(let id):
            return "/cart/\(id)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .authorize, .addCart:
            return .post
        case .deleteSmartphone, .deleteLaptop, .deleteTV,
             .deleteCart:
            return .delete
        default:
            return .get
        }
    }

    var parameters: [String: Any]? {
        switch self {
        case .addCart(let id, let productId):
            return [
                "productId": id,
                "productTypeId": productId
            ]
        default:
            return nil
        }
    }

    var sampleData: Data {
        switch self {
        case .authorize(let login, let password):
            return stubbedResponse("authorize-\(login)-\(password)")
        case .smartphones:
            return stubbedResponse("products-smartphones")
        case .smartphone(let id):
            return stubbedResponse("products-smartphone-\(id)")
        case .laptops:
            return stubbedResponse("products-laptops")
        case .laptop(let id):
            return stubbedResponse("products-laptop-\(id)")
        case .tvs:
            return stubbedResponse("products-tvs")
        case .tv(let id):
            return stubbedResponse("products-tv-\(id)")
        default:
            return Data()
        }
    }

    var task: Task {
        if let parameters = self.parameters {
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
        return .requestPlain // TEMP
    }

    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }

    var validationType: ValidationType {
        return .successCodes
    }
}

// MARK: - Utils
private extension eStoreAPI {
    func stubbedResponse(_ name: String) -> Data {
        @objc class TestClass: NSObject { }

        let bundle = Bundle(for: TestClass.self)
        guard let url = bundle.url(forResource: name, withExtension: "json") else {
            return Data()
        }
        return (try? Data(contentsOf: url)) ?? Data()
    }
}
