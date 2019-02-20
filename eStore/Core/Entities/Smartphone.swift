//
//  Smartphone.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/20/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

// TODO: Make class mappable
class Smartphone {
    var id: Int
    var name: String
    var brand: Brand
    var batteryCapacity: Int
    var display: Display
    var operatingSystem: OperatingSystem
    // Processor

    init(id: Int,
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
}

// MARK: - StoreItem implementation
extension Smartphone: StoreItem { }
