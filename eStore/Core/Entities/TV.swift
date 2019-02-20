//
//  TV.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/20/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

// TODO: Make class mappable
class TV {
    var id: Int
    var name: String
    var brand: Brand
    var display: Display
    var operatingSystem: OperatingSystem

    init(id: Int,
         name: String,
         brand: Brand,
         display: Display,
         operatingSystem: OperatingSystem) {
        
        self.id = id
        self.name = name
        self.brand = brand
        self.display = display
        self.operatingSystem = operatingSystem
    }
}

// MARK: - StoreItem implementation
extension TV: StoreItem { }
