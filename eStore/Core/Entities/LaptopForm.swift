//
//  LaptopForm.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 12/18/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

struct LaptopForm {
    let imageUrl: String?
    let name: String
    let brandName: String
    let operatingSystem: OperatingSystem
    let display: Display
    let ramCapacity: Int
    let memoryCapacity: Int
    let processorName: String
    let graphicsAdapter: String
    let color: String
    let batteryCapacity: Int
    let price: Int
}

extension LaptopForm {
    func toParameters() -> [String: Any] {
        return [
            "imageUrl": imageUrl,
            "name": name,
            "brandName": brandName,
            "operatingSystemRawValue": operatingSystem.rawValue,
            "resolutionWidth": display.width,
            "resolutionHeight": display.height,
            "ramCapacity": ramCapacity,
            "memoryCapacity": memoryCapacity,
            "processorName": processorName,
            "graphicsAdapter": graphicsAdapter,
            "color": color,
            "batteryCapacity": batteryCapacity,
            "price": price
        ]
    }
}
