//
//  StoreItem.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/20/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

protocol StoreItemConvertible {
    func toStoreItem() -> StoreItem
}

class StoreItem {
    let id: String
    let imageUrl: String?
    let name: String
    let brand: String
    let type: ProductType
    let specifications: [Specification]
    let price: Int
    let stockCount: Int

    init(id: String,
         imageUrl: String?,
         name: String,
         brand: String,
         type: ProductType,
         specifications: [Specification],
         price: Int,
         stockCount: Int) {

        self.id = id
        self.imageUrl = imageUrl
        self.name = name
        self.brand = brand
        self.type = type
        self.specifications = specifications
        self.price = price
        self.stockCount = stockCount
    }
}
