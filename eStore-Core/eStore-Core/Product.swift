//
//  Product.swift
//  eStore-Core
//
//  Created by Vladislav Kondrashkov on 10/27/19.
//  Copyright © 2019 vkondrashkov. All rights reserved.
//

import Foundation

public class Product {
    public let id: String
    public let name: String
    public let brandName: String
    public let imageURL: String?
    public let price: Double
    public let specifications: [Specification]

    public init(id: String,
                name: String,
                brandName: String,
                imageURL: String?,
                price: Double,
                specifications: [Specification]) {
        self.id = id
        self.name = name
        self.brandName = brandName
        self.imageURL = imageURL
        self.price = price
        self.specifications = specifications
    }
}
