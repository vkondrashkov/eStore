//
//  Specification.swift
//  eStore-Core
//
//  Created by Vladislav Kondrashkov on 10/27/19.
//  Copyright © 2019 vkondrashkov. All rights reserved.
//

import Foundation

public class Specification {
    public enum Value {
        case bool(Bool)
        case int(Int)
        case string(String)
        case double(Double)
    }

    public let name: String
    public let value: Specification.Value

    init(name: String, value: Specification.Value) {
        self.name = name
        self.value = value
    }
}
