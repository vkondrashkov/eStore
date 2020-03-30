//
//  Smartphone.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/20/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import ObjectMapper

class Smartphone: ImmutableMappable {
    let id: Int
    let imageUrl: String?
    let name: String
    let brandName: String
    let operatingSystem: OperatingSystem
    let display: Display
    let ramCapacity: Int
    let memoryCapacity: Int
    let processorName: String
    let color: String
    let batteryCapacity: Int
    let price: Int

    required init(map: Map) throws {
        id = try map.value("id")
        imageUrl = try? map.value("imageUrl")
        name = try map.value("name")
        brandName = try map.value("brandName")
        operatingSystem = try OperatingSystem(rawValue: map.value("operatingSystemRawValue")) ?? .unknown
        display = Display(width: try map.value("resolutionWidth"), height: try map.value("resolutionHeight"))
        ramCapacity = try map.value("ramCapacity")
        memoryCapacity = try map.value("memoryCapacity")
        processorName = try map.value("processorName")
        color = try map.value("color")
        batteryCapacity = try map.value("batteryCapacity")
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
        ramCapacity >>> map["ramCapacity"]
        memoryCapacity >>> map["memoryCapacity"]
        processorName >>> map["processorName"]
        color >>> map["color"]
        batteryCapacity >>> map["batteryCapacity"]
        price >>> map["price"]
    }
}

// MARK: - StoreItemConvertible implementation
extension Smartphone: StoreItemConvertible {
    func toStoreItem() -> StoreItem {
        var specifications: [Specification] = []
        specifications.append(Specification(name: "Operating system", value: operatingSystem.title))
        specifications.append(Specification(name: "Display", value: display))
        specifications.append(Specification(name: "RAM", value: "\(ramCapacity) GB"))
        specifications.append(Specification(name: "Flash memory", value: "\(memoryCapacity) GB"))
        specifications.append(Specification(name: "Processor", value: processorName))
        specifications.append(Specification(name: "Color", value: color))
        specifications.append(Specification(name: "Battery capacity", value: "\(batteryCapacity) mAh"))
        let storeItem = StoreItem(
            id: id,
            imageUrl: imageUrl,
            name: name,
            brand: brandName,
            type: .smartphone,
            specifications: specifications,
            price: price,
            stockCount: 1
        )
        return storeItem
    }
}
