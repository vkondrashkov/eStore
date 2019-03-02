//
//  Smartphone.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/20/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import ObjectMapper

class Smartphone: ImmutableMappable {
    var id: String
    var name: String
    var brand: Brand
    var batteryCapacity: Int
    var display: Display
    var operatingSystem: OperatingSystem
    // Processor

    init(id: String,
         name: String,
         brand: Brand,
         batteryCapacity: Int,
         display: Display,
         operatingSystem: OperatingSystem) {

        self.id = id
        self.name = name
        self.brand = brand
        self.batteryCapacity = batteryCapacity
        self.display = display
        self.operatingSystem = operatingSystem
    }

    required init(map: Map) throws {
        id = try map.value("id")
        name = try map.value("name")
        brand = Brand(id: 0, name: "") // Temprorary
        batteryCapacity = try map.value("batteryCapacity")
        display = Display(width: 0, height: 0) // Temprorary
        operatingSystem = .iOS // Temporary
    }

    func mapping(map: Map) {
//        date >>> (map["dt_txt"], DateTransform())
//        temperature >>> map["main.temp"]
//        status >>> map["weather.0.description"]
    }
}

// MARK: - StoreItem implementation
//extension Smartphone: StoreItem { }
