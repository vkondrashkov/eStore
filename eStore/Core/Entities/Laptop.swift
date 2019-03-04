//
//  Laptop.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/20/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import ObjectMapper

// TODO: Expand class fields
class Laptop: ImmutableMappable {
    var id: String
    var name: String
    var brand: String
    var operatingSystem: OperatingSystem
    var display: Display
    var processor: String
    var price: Int

    init(id: String,
         name: String,
         brand: String,
         operatingSystem: OperatingSystem,
         display: Display,
         processor: String,
         price: Int) {

        self.id = id
        self.name = name
        self.brand = brand
        self.operatingSystem = operatingSystem
        self.display = display
        self.processor = processor
        self.price = price
    }

    required init(map: Map) throws {
        id = try map.value("id")
        name = try map.value("name")
        brand = try map.value("brand")
        operatingSystem = try OperatingSystem(rawValue: map.value("operatingSystem")) ?? .unknown
        display = Display(width: try map.value("display.width"), height: try map.value("display.height"))
        processor = try map.value("processor")
        price = try map.value("price")
    }

    func mapping(map: Map) {
        id >>> map["id"]
        name >>> map["name"]
        brand >>> map["brand"]
        operatingSystem.rawValue >>> map["operatingSystem"]
        display.width >>> map["display.width"]
        display.height >>> map["display.height"]
        processor >>> map["processor"]
        price >>> map["price"]
    }
}

// MARK: - StoreItem implementation
extension Laptop: StoreItem {
    var fullName: String {
        return "\(brand) \(name)"
    }

    var description: String {
        return "\(operatingSystem), display \(display.description), \(processor)"
    }
}

// MARK: - Equatable implementation
extension Laptop: Equatable {
    static func == (lhs: Laptop, rhs: Laptop) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.brand == rhs.brand &&
            lhs.operatingSystem == rhs.operatingSystem &&
            lhs.display == rhs.display &&
            lhs.processor == rhs.processor &&
            lhs.price == rhs.price
    }
}
