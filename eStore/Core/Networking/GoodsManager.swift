//
//  GoodsManager.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/2/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import Foundation
import ObjectMapper

protocol GoodsManager {
    func fetchSmartphones(from json: String, completion: @escaping ([Smartphone]?) -> Void)
    func fetchLaptops(from json: [String: Any], completion: @escaping ([Laptop]) -> Void)
    func fetchTV(from json: [String: Any], completion: @escaping ([TV]) -> Void)
}

class GoodsManagerImpl: GoodsManager {
    func fetchSmartphones(from json: String, completion: @escaping ([Smartphone]?) -> Void) {
        let smartphonesList = try? Mapper<Smartphone>().mapArray(JSONString: json)
        completion(smartphonesList)
    }

    func fetchLaptops(from json: [String: Any], completion: @escaping ([Laptop]) -> Void) {

    }

    func fetchTV(from json: [String: Any], completion: @escaping ([TV]) -> Void) {

    }
}
