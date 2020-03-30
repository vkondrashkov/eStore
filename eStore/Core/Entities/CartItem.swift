//
//  CartItem.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 12/17/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import ObjectMapper

class CartItem: ImmutableMappable {
    let id: Int
    let productId: Int
    let imageUrl: String?
    let name: String
    let brandName: String
    let price: Int

    required init(map: Map) throws {
        id = try map.value("id")
        productId = try map.value("productId")
        imageUrl = try? map.value("imageUrl")
        name = try map.value("name")
        brandName = try map.value("brandName")
        price = try map.value("price")
    }

    func mapping(map: Map) {
        id >>> map["id"]
        productId >>> map["productId"]
        imageUrl >>> map["imageUrl"]
        name >>> map["name"]
        brandName >>> map["brandName"]
        price >>> map["price"]
    }
}

extension CartItem: StoreItemConvertible {
    func toStoreItem() -> StoreItem {
        let tempProductType: ProductType
        switch productId {
        case 0:
            tempProductType = .smartphone
        case 1:
            tempProductType = .laptop
        case 2:
            tempProductType = .tv
        default:
            tempProductType = .smartphone
        }
        return StoreItem(
            id: id,
            imageUrl: imageUrl,
            name: name,
            brand: brandName,
            type: tempProductType,
            specifications: [],
            price: price,
            stockCount: 1
        )
    }
}
