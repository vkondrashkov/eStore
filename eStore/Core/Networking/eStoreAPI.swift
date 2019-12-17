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
    case register(login: String, password: String)

    case addSmartphone(userId: Int, smartphoneForm: SmartphoneForm)
    case smartphones
    case smartphone(id: String)
    case deleteSmartphone(id: Int)

    case addLaptop(userId: Int, laptopForm: LaptopForm)
    case laptops
    case laptop(id: String)
    case deleteLaptop(id: Int)

    case tvs
    case tv(id: String)
    case deleteTV(id: Int)

    case cart(userId: Int)
    case addCart(userId: Int, productId: Int, productTypeId: Int)
    case deleteCart(userId: Int, cartItemId: Int)
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
            return "/user/authorize"
        case .register:
            return "/user/register"
        case .addSmartphone:
            return "/smartphone"
        case .smartphones:
            return "/smartphone"
        case .smartphone(let id):
            return "/smartphone/\(id)"
        case .deleteSmartphone(let id):
            return "/smartphone/\(id)"
        case .addLaptop:
            return "/laptop"
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
        case .deleteCart(_, let id):
            return "/cart/\(id)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .authorize, .register, .addCart, .addSmartphone,
             .addLaptop:
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
        case .addCart(_, let productId, let productTypeId):
            return [
                "productId": productId,
                "productTypeId": productTypeId
            ]
        case .authorize(let login, let password):
            return [
                "login": login,
                "password": password.hashed(.sha512)!
            ]
        case .register(let login, let password):
            return [
                "login": login,
                "password": password.hashed(.sha512)!
            ]
        case .addSmartphone(_, let smartphoneForm):
            return smartphoneForm.toParameters()
        case .addLaptop(_, let laptopForm):
            return laptopForm.toParameters()
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

    var headers: [String: String]? {
        var headers: [String: String] = ["Content-Type": "application/json"]
        switch self {
        case .cart(let userId):
            headers["userId"] = String(userId)
        case .addCart(let userId, _, _):
            headers["userId"] = String(userId)
        case .deleteCart(let userId, _):
            headers["userId"] = String(userId)
        case .addSmartphone(let userId, _):
            headers["userId"] = String(userId)
        case .addLaptop(let userId, _):
            headers["userId"] = String(userId)
        default:
            break
        }
        return headers
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
