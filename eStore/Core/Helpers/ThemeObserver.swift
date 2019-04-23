//
//  ThemeObserver.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 4/8/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

protocol ThemeObserver: AnyObject {
    func didChangedTheme(_ theme: Theme)
}
