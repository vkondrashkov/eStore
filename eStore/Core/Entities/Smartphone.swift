//
//  Smartphone.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/20/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import ObjectMapper

class Smartphone: ImmutableMappable {
    let id: String
    let name: String
    let brand: String
    let operatingSystem: OperatingSystem
    let display: Display
    let ram: Int
    let flashMemory: Int
    let processor: String
    let color: String
    let batteryCapacity: Int
    let price: Int
    let stockCount: Int

    required init(map: Map) throws {
        id = try map.value("id")
        name = try map.value("name")
        brand = try map.value("brand")
        operatingSystem = try OperatingSystem(rawValue: map.value("operatingSystem")) ?? .unknown
        display = Display(width: try map.value("display.width"), height: try map.value("display.height"))
        ram = try map.value("ram")
        flashMemory = try map.value("flashMemory")
        processor = try map.value("processor")
        color = try map.value("color")
        batteryCapacity = try map.value("batteryCapacity")
        price = try map.value("price")
        stockCount = try map.value("stockCount")
    }

    func mapping(map: Map) {
        id >>> map["id"]
        name >>> map["name"]
        brand >>> map["brand"]
        operatingSystem.rawValue >>> map["operatingSystem"]
        display.width >>> map["display.width"]
        display.height >>> map["display.height"]
        ram >>> map["ram"]
        flashMemory >>> map["flashMemory"]
        processor >>> map["processor"]
        color >>> map["color"]
        batteryCapacity >>> map["batteryCapacity"]
        price >>> map["price"]
        stockCount >>> map["stockCount"]
    }
}

// MARK: - StoreItemConvertible implementation
extension Smartphone: StoreItemConvertible {
    func toStoreItem() -> StoreItem {
        var specifications: [Specification] = []
        specifications.append(Specification(name: "Operating system", value: operatingSystem))
        specifications.append(Specification(name: "Display", value: display))
        specifications.append(Specification(name: "RAM", value: "\(ram) GB"))
        specifications.append(Specification(name: "Flash memory", value: "\(flashMemory) GB"))
        specifications.append(Specification(name: "Processor", value: processor))
        specifications.append(Specification(name: "Color", value: color))
        specifications.append(Specification(name: "Battery capacity", value: batteryCapacity))
        let storeItem = StoreItem(
            id: id,
            name: name,
            brand: brand,
            type: .Smartphone,
            specifications: specifications,
            price: price,
            stockCount: stockCount
        )
        return storeItem
    }
}
