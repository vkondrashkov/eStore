//
//  StoreItem.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/20/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

// TODO: Add StockCount property
protocol StoreItem: PropertyReflectable {
    var id: String { get }
    var fullName: String { get }
    var description: String { get }
    var price: Int { get }
}
