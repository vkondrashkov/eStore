//
//  GoodsManager.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/2/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import Foundation

protocol GoodsManager {
    func fetchSmartphones(from json: [String: Any], completion: @escaping ([Smartphone]) -> Void)
    func fetchLaptops(from json: [String: Any], completion: @escaping ([Laptop]) -> Void)
    func fetchTV(from json: [String: Any], completion: @escaping ([TV]) -> Void)
}

class GoodsManagerImpl: GoodsManager {
    func fetchSmartphones(from json: [String: Any], completion: @escaping ([Smartphone]) -> Void) {

    }

    func fetchLaptops(from json: [String: Any], completion: @escaping ([Laptop]) -> Void) {

    }

    func fetchTV(from json: [String: Any], completion: @escaping ([TV]) -> Void) {

    }
}
