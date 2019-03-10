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
// TODO: Add StockCount property
class StoreItem {
    var id: String
    var name: String
    var brand: String
    var specifications: [Specification]
    var price: Int

    init(id: String,
         name: String,
         brand: String,
         specifications: [Specification],
         price: Int) {

        self.id = id
        self.name = name
        self.brand = brand
        self.specifications = specifications
        self.price = price
    }
}
