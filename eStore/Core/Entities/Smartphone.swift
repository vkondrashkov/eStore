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

    init(id: String,
         name: String,
         brand: String,
         operatingSystem: OperatingSystem,
         display: Display,
         ram: String,
         flashMemory: String,
         processor: String,
         color: String,
         batteryCapacity: Int,
         price: Int) {

        self.id = id
        self.name = name
        self.brand = brand
        self.operatingSystem = operatingSystem
        self.display = display
        self.ram = ram
        self.flashMemory = flashMemory
        self.processor = processor
        self.color = color
        self.batteryCapacity = batteryCapacity
        self.price = price
    }

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

// MARK: - StoreItem implementation
extension Smartphone: StoreItem {
    var fullName: String {
        return "\(brand) \(name)"
    }

    var description: String {
        return "\(operatingSystem), display \(display.description), \(processor), RAM \(ram), flash memory \(flashMemory), battery capacity \(batteryCapacity), color \(color)"
    }
}

// MARK: - Equatable implementation
extension Smartphone: Equatable {
    static func == (lhs: Smartphone, rhs: Smartphone) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.brand == rhs.brand &&
            lhs.operatingSystem == rhs.operatingSystem &&
            lhs.display == rhs.display &&
            lhs.ram == rhs.ram &&
            lhs.flashMemory == rhs.flashMemory &&
            lhs.processor == rhs.processor &&
            lhs.color == rhs.color &&
            lhs.batteryCapacity == rhs.batteryCapacity &&
            lhs.price == rhs.price
    }
}
