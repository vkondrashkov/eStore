//
//  Display.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/20/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

struct Display {
    let width: Int
    let height: Int

    var description: String {
        return "\(width)x\(height)"
    }
}

// MARK: - Equatable implementation
extension Display: Equatable {
    static func == (lhs: Display, rhs: Display) -> Bool {
        return lhs.width == rhs.width && lhs.height == rhs.height
    }
}
