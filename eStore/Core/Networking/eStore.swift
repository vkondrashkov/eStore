//
//  eStore.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 11/17/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import Moya

enum eStore {
    case getSmartphones
    case getSmartphone(_ id: String)
    // TODO: post/delete smartphone
    case getLaptops
    case getLaptop(_ id: String)
    // TODO: post/delete laptop
    case getTVs
    case getTV(_ id: String)
    // TODO: post/delete tv
}

// MARK: TargetType implementation
extension eStore: TargetType {
    var baseURL: URL {
        return URL(string: "http://localhost:8080")!
    }

    var path: String {
        switch self {
        case .getSmartphones:
            return "/smartphones"
        case .getSmartphone(let id):
            return "/smartphones/\(id)"
        case .getLaptops:
            return "/laptops"
        case .getLaptop(let id):
            return "/laptops/\(id)"
        case .getTVs:
            return "/tvs"
        case .getTV(let id):
            return "/tvs/\(id)"
        }
    }

    var method: Method {
        switch self {
        case .getSmartphones, .getSmartphone:
            return .get
        case .getLaptops, .getLaptop:
            return .get
        case .getTVs, .getTV:
            return .get
        }
    }

    var sampleData: Data {
        switch self {
        case .getSmartphones:
            return makeStubData(name: "products-smartphones")
        case .getSmartphone(let id):
            return makeStubData(name: "products-smartphone-\(id)")
        case .getLaptops:
            return makeStubData(name: "products-laptops")
        case .getLaptop(let id):
            return makeStubData(name: "products-laptop-\(id)")
        case .getTVs:
            return makeStubData(name: "products-tvs")
        case .getTV(let id):
            return makeStubData(name: "products-tv-\(id)")
        }
    }

    private func makeStubData(name: String) -> Data {
        let stubUrl = Bundle.main.url(forResource: "\(name)-stub", withExtension: "json")
        guard let url = stubUrl else {
            return Data()
        }
        let data = try? Data(contentsOf: url)
        return data ?? Data()
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
