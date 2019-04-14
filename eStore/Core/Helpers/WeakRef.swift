//
//  WeakRef.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 4/8/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

class WeakRef<T> where T: AnyObject {
    private(set) weak var value: T?

    init(value: T?) {
        self.value = value
    }
}
