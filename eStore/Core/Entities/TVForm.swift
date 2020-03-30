//
//  TVForm.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 12/18/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

struct TVForm {
    let imageUrl: String?
    let name: String
    let brandName: String
    let operatingSystem: OperatingSystem
    let display: Display
    let price: Int
}

extension TVForm {
    func toParameters() -> [String: Any] {
        return [
            "imageUrl": imageUrl,
            "name": name,
            "brandName": brandName,
            "operatingSystemRawValue": operatingSystem.rawValue,
            "resolutionWidth": display.width,
            "resolutionHeight": display.height,
            "price": price
        ]
    }
}
