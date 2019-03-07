//
//  Smartphone.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/20/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import ObjectMapper

// TODO: Add StockCount property
class Smartphone: ImmutableMappable {
    let id: String
    let name: String
    let brand: String
    let operatingSystem: OperatingSystem
    let display: Display
    let ram: String
    let flashMemory: String
    let processor: String
    let color: String
    let batteryCapacity: Int
    let price: Int

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
    }
}

// MARK: - StoreItemConvertible implementation
extension Smartphone: StoreItemConvertible {
    func toStoreItem() -> StoreItem {
        let storeItem = StoreItem(
            id: id,
            name: name,
            brand: brand,
            type: .smartphone(data: self),
            price: price
        )
        return storeItem
    }
}
