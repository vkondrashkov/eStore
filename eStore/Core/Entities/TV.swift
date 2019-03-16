//
//  TV.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/20/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import ObjectMapper

// TODO: Expand class fields
class TV: ImmutableMappable {
    let id: String
    let imageUrl: String?
    let name: String
    let brand: String
    let display: Display
    let operatingSystem: OperatingSystem
    let price: Int

    required init(map: Map) throws {
        id = try map.value("id")
        imageUrl = try? map.value("imageUrl")
        name = try map.value("name")
        brand = try map.value("brand")
        operatingSystem = try OperatingSystem(rawValue: map.value("operatingSystem")) ?? .unknown
        display = Display(width: try map.value("display.width"), height: try map.value("display.height"))
        price = try map.value("price")
    }

    func mapping(map: Map) {
        id >>> map["id"]
        imageUrl >>> map["imageUrl"]
        name >>> map["name"]
        brand >>> map["brand"]
        operatingSystem.rawValue >>> map["operatingSystem"]
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
            brand: brand,
            type: .TV,
            specifications: specifications,
            price: price
        )
        return storeItem
    }
}
