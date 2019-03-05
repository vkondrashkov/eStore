//
//  PropertyReflectable.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/5/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import Foundation

protocol PropertyReflectable {
    var properties: [String] { get }
}

extension PropertyReflectable {
    var properties: [String] {
        return Mirror(reflecting: self).children.flatMap { $0.label }
    }

    subscript(key: String) -> Any? {
        let mirror = Mirror(reflecting: self)
        for child in mirror.children {
            guard child.label == key else { continue }

            return child.value
        }
        return nil
    }
}
