//
//  TV.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/20/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import ObjectMapper

class TV: ImmutableMappable {
    let id: Int
    let imageUrl: String?
    let name: String
    let brandName: String
    let display: Display
    let operatingSystem: OperatingSystem
    let price: Int

    required init(map: Map) throws {
        id = try map.value("id")
        imageUrl = try? map.value("imageUrl")
        name = try map.value("name")
        brandName = try map.value("brandName")
        operatingSystem = try OperatingSystem(rawValue: map.value("operatingSystemRawValue")) ?? .unknown
        display = Display(width: try map.value("resolutionWidth"), height: try map.value("resolutionHeight"))
        price = try map.value("price")
    }

    func mapping(map: Map) {
        id >>> map["id"]
        imageUrl >>> map["imageUrl"]
        name >>> map["name"]
        brandName >>> map["brandName"]
        operatingSystem.rawValue >>> map["operatingSystemRawValue"]
        display.width >>> map["display.width"]
        display.height >>> map["display.height"]
        price >>> map["price"]
    }
}

// MARK: - StoreItemConvertible implementation
extension TV: StoreItemConvertible {
    func toStoreItem() -> StoreItem {
        var specifications: [Specification] = []
        specifications.append(Specification(name: "Operating system", value: operatingSystem))
        specifications.append(Specification(name: "Display", value: display))
        let storeItem = StoreItem(
            id: id,
            imageUrl: imageUrl,
            name: name,
            brand: brandName,
            type: .tv,
            specifications: specifications,
            price: price,
            stockCount: 1
        )
        return storeItem
    }
}
