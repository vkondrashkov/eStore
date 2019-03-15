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
    func fetchLaptops(from json: String, completion: @escaping ([Laptop]?) -> Void)
    func fetchTV(from json: String, completion: @escaping ([TV]?) -> Void)
}

class GoodsManagerImpl: GoodsManager {
    func fetchSmartphones(from json: String, completion: @escaping ([Smartphone]?) -> Void) {
        let smartphonesList = try? Mapper<Smartphone>().mapArray(JSONString: json)
        completion(smartphonesList)
    }

    func fetchLaptops(from json: String, completion: @escaping ([Laptop]?) -> Void) {
        let laptopsList = try? Mapper<Laptop>().mapArray(JSONString: json)
        completion(laptopsList)
    }

    func fetchTV(from json: String, completion: @escaping ([TV]?) -> Void) {
        let tvList = try? Mapper<TV>().mapArray(JSONString: json)
        completion(tvList)
    }
}
