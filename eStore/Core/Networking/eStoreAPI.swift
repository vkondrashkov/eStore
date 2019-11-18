//
//  eStoreAPI.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 11/17/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import Moya

enum eStoreAPI {
    case smartphones
    case smartphone(id: String)
    case deleteSmartphone(id: String)

    case laptops
    case laptop(id: String)
    case deleteLaptop(id: String)

    case tvs
    case tv(id: String)
    case deleteTV(id: String)
}

// MARK: TargetType implementation
extension eStoreAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://localhost:8080")!
    }

    var path: String {
        switch self {
        case .smartphones:
            return "/smartphones"
        case .smartphone(let id):
            return "/smartphones/\(id)"
        case .deleteSmartphone(let id):
            return "/smartphones/\(id)"
        case .laptops:
            return "/laptops"
        case .laptop(let id):
            return "/laptops/\(id)"
        case .deleteLaptop(let id):
            return "/laptops/\(id)"
        case .tvs:
            return "/tvs"
        case .tv(let id):
            return "/tvs/\(id)"
        case .deleteTV(let id):
            return "/tvs/\(id)"
        }
    }

    var method: Method {
        switch self {
        case .deleteSmartphone, .deleteLaptop, .deleteTV:
            return .delete
        default:
            return .get
        }
    }

    var sampleData: Data {
        switch self {
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
