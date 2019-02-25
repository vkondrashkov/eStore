//
//  Coordinator.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 2/6/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import Foundation

protocol Coordinator: AnyObject {
    func start()
    func stop(completion: (() -> Void)?)
}
