//
//  ProductType.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/10/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

enum ProductType: Int {
    case smartphone
    case laptop
    case tv

    var title: String {
        switch self {
        case .smartphone:
            return "Smartphone"
        case .laptop:
            return "Laptop"
        case .tv:
            return "TV"
        }
    }
}
