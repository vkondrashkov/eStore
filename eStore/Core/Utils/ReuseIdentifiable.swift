//
//  ReuseIdentifiable.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 4/22/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

protocol ReuseIdentifiable {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifiable where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
