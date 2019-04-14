//
//  ThemeUpdatable.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 4/11/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

protocol ThemeUpdatable {
    func apply(theme: Theme, animated: Bool)
}
