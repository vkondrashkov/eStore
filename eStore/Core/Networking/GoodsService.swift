//
//  GoodsService.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/10/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import ObjectMapper

protocol GoodsService {
    func getSmartphone(completion: @escaping ([StoreItem]?) -> Void)
    func getLaptops(completion: @escaping ([StoreItem]?) -> Void)
    func getTV(completion: @escaping ([StoreItem]?) -> Void)
}

class GoodsServiceImpl: GoodsService {
    func getSmartphone(completion: @escaping ([StoreItem]?) -> Void) {
        // Temp json
        let json = "[{ \"id\": \"3571539fcbe330452d4d938502ed9f15\", \"imageUrl\": \"https://content2.onliner.by/catalog/device/header@2/0ab0b43eb38b5767ea29c4509f0a9d3b.jpeg\", \"brand\": \"Apple\", \"name\": \"iPhone 7 128GB Black\", \"operatingSystem\": \"iOS\", \"display\": { \"width\": 750, \"height\": 1334 }, \"ram\": 2, \"flashMemory\": 128, \"processor\": \"Apple A10 Fusion\", \"color\": \"Black\", \"batteryCapacity\": 1960, \"price\": 1389, \"stockCount\": 12 }, { \"id\": \"1192ee0cfbc6d237211c9c3b45423260\", \"imageUrl\": \"https://content2.onliner.by/catalog/device/header@2/4fd64af4d5bccc1d8907191af785d5fa.jpeg\", \"brand\": \"Apple\", \"name\": \"iPhone 7 32GB Rose Gold\", \"operatingSystem\": \"iOS\", \"display\": { \"width\": 750, \"height\": 1334 }, \"ram\": 2, \"flashMemory\": 32, \"processor\": \"Apple A10 Fusion\", \"color\": \"Rose Gold\", \"batteryCapacity\": 1960, \"price\": 1190, \"stockCount\": 18 }, { \"id\": \"3571539fcbe330452d4d938502ed9f15\", \"imageUrl\": \"https://content2.onliner.by/catalog/device/header/a660b069b77682ba4b5b84ef87fd09da.jpeg\", \"brand\": \"Samsung\", \"name\": \"Galaxy S10+ G975 8GB/128GB Dual Sim Exynos 9820 Onyx\", \"operatingSystem\": \"Android\", \"display\": { \"width\": 1440, \"height\": 3040 }, \"ram\": 8, \"flashMemory\": 128, \"processor\": \"Exynos 9820\", \"color\": \"Onyx\", \"batteryCapacity\": 4100, \"price\": 2549, \"stockCount\": 0 } ]"
        let smartphonesList = try? Mapper<Smartphone>().mapArray(JSONString: json)
        completion(smartphonesList?.map { $0.toStoreItem() })
    }

    func getLaptops(completion: @escaping ([StoreItem]?) -> Void) {
        // Temp json
        let json = "[{ \"id\": \"34ec91a46a12a40fc44c414b61b638e6\", \"imageUrl\": \"https://content2.onliner.by/catalog/device/header/69fd1638fafefbe0ecc02ab7fd9391f0.jpeg\", \"brand\": \"Apple\", \"name\": \"MacBook Air 13\'\' (2017 год) [MQD32]\", \"operatingSystem\": \"MacOs\", \"display\": { \"width\": 1440, \"height\": 900 }, \"processor\": \"Intel Core i5 5350U\", \"price\": 2129, \"stockCount\": 6 }, { \"id\": \"c584ce7e3117e3563b1bf0450844d459\", \"imageUrl\": \"https://content2.onliner.by/catalog/device/header/d5fb0dbff218465e5e2cb70d49007d28.jpeg\", \"brand\": \"Xiaomi\", \"name\": \"Mi Notebook Pro 15.6 JYU4036CN\", \"operatingSystem\": \"Windows\", \"display\": { \"width\": 1920, \"height\": 1080 }, \"processor\": \"Intel Core i5 8250U\", \"price\": 2202, \"stockCount\": 0 }]"
        let laptopsList = try? Mapper<Laptop>().mapArray(JSONString: json)
        completion(laptopsList?.map { $0.toStoreItem() })
    }

    func getTV(completion: @escaping ([StoreItem]?) -> Void) {
        // Temp json
        let json = "[{ \"id\": \"09af2b066b649bbb8ff54dafca4660fe\", \"imageUrl\": \"https://content2.onliner.by/catalog/device/header/921d9b7a3dc1fcb5f44b78cd4649dac7.jpeg\", \"brand\": \"Samsung\", \"name\": \"UE43NU7100U\", \"operatingSystem\": \"WebOs\", \"display\": { \"width\": 3840, \"height\": 2160 }, \"price\": 991, \"stockCount\": 0 }, { \"id\": \"1490ab49c5af2773450bc6c017477029\", \"imageUrl\": \"https://content2.onliner.by/catalog/device/header/7f76d8e82eb6da4732f9dfeefd46247f.jpeg\", \"brand\": \"Xiaomi\", \"name\": \"MI TV 4A Pro 43\'\'\", \"operatingSystem\": \"WebOs\", \"display\": { \"width\": 1920, \"height\": 1080 }, \"price\": 858, \"stockCount\": 4 }]"
        let tvList = try? Mapper<TV>().mapArray(JSONString: json)
        completion(tvList?.map { $0.toStoreItem() })
    }
}
