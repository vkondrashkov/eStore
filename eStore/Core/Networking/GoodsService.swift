//
//  GoodsService.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 3/10/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

protocol GoodsService {
    func getSmartphone(completion: @escaping ([StoreItem]?) -> Void)
    func postSmartphone(smartphone: Smartphone, completion: @escaping (StoreItem?) -> Void)

    func getLaptops(completion: @escaping ([StoreItem]?) -> Void)

    func getTV(completion: @escaping ([StoreItem]?) -> Void)
}

class GoodsServiceImpl {
    let manager: GoodsManager

    init() {
        manager = GoodsManagerImpl()
    }
}

// MARK: - GoodsService implementation
extension GoodsServiceImpl: GoodsService {
    func getSmartphone(completion: @escaping ([StoreItem]?) -> Void) {
        // Temp json
        let json = "[{ \"id\": \"3571539fcbe330452d4d938502ed9f15\", \"brand\": \"Apple\", \"name\": \"iPhone 7 128GB Black\", \"operatingSystem\": \"iOS\", \"display\": { \"width\": 750, \"height\": 1334 }, \"ram\": \"2 GB\", \"flashMemory\": \"128 GB\", \"processor\": \"Apple A10 Fusion\", \"color\": \"Black\", \"batteryCapacity\": 1960, \"price\": 1389, \"stockCount\": 12 }, { \"id\": \"1192ee0cfbc6d237211c9c3b45423260\", \"brand\": \"Apple\", \"name\": \"iPhone 7 32GB Rose Gold\", \"operatingSystem\": \"iOS\", \"display\": { \"width\": 750, \"height\": 1334 }, \"ram\": \"2 GB\", \"flashMemory\": \"32 GB\", \"processor\": \"Apple A10 Fusion\", \"color\": \"Rose Gold\", \"batteryCapacity\": 1960, \"price\": 1190, \"stockCount\": 18 }, { \"id\": \"3571539fcbe330452d4d938502ed9f15\", \"brand\": \"Samsung\", \"name\": \"Galaxy S10+ G975 8GB/128GB Dual Sim Exynos 9820 Onyx\", \"operatingSystem\": \"Android\", \"display\": { \"width\": 1440, \"height\": 3040 }, \"ram\": \"8 GB\", \"flashMemory\": \"128 GB\", \"processor\": \"Exynos 9820\", \"color\": \"Onyx\", \"batteryCapacity\": 4100, \"price\": 2549, \"stockCount\": 3 } ]"
        manager.fetchSmartphones(from: json, completion: { result in
            guard let smartphones = result else {
                completion(nil)
                return
            }
            var storeItemList: [StoreItem] = []
            for smartphone in smartphones {
                storeItemList.append(smartphone.toStoreItem())
            }
            completion(storeItemList)
        })
    }

    func postSmartphone(smartphone: Smartphone, completion: @escaping (StoreItem?) -> Void) {

    }

    func getLaptops(completion: @escaping ([StoreItem]?) -> Void) {
        // Temp json
        let json = "[{ \"id\": \"34ec91a46a12a40fc44c414b61b638e6\", \"brand\": \"Apple\", \"name\": \"MacBook Air 13\'\' (2017 год) [MQD32]\", \"operatingSystem\": \"MacOs\", \"display\": { \"width\": 1440, \"height\": 900 }, \"processor\": \"Intel Core i5 5350U\", \"price\": 2129, \"stockCount\": 6 }, { \"id\": \"c584ce7e3117e3563b1bf0450844d459\", \"brand\": \"Xiaomi\", \"name\": \"Mi Notebook Pro 15.6 JYU4036CN\", \"operatingSystem\": \"Windows\", \"display\": { \"width\": 1920, \"height\": 1080 }, \"processor\": \"Intel Core i5 8250U\", \"price\": 2202, \"stockCount\": 2 }]"
        manager.fetchLaptops(from: json, completion: { result in
            guard let laptops = result else {
                completion(nil)
                return
            }
            var storeItemList: [StoreItem] = []
            for laptop in laptops {
                storeItemList.append(laptop.toStoreItem())
            }
            completion(storeItemList)
        })

    }

    func getTV(completion: @escaping ([StoreItem]?) -> Void) {
        // Temp json
        let json = "[{ \"id\": \"09af2b066b649bbb8ff54dafca4660fe\", \"brand\": \"Samsung\", \"name\": \"UE43NU7100U\", \"operatingSystem\": \"WebOs\", \"display\": { \"width\": 3840, \"height\": 2160 }, \"price\": 991, \"stockCount\": 6 }, { \"id\": \"1490ab49c5af2773450bc6c017477029\", \"brand\": \"Xiaomi\", \"name\": \"MI TV 4A Pro 43\'\'\", \"operatingSystem\": \"WebOs\", \"display\": { \"width\": 1920, \"height\": 1080 }, \"price\": 858, \"stockCount\": 4 }]"
        manager.fetchTV(from: json, completion: { result in
            guard let tvList = result else {
                completion(nil)
                return
            }
            var storeItemList: [StoreItem] = []
            for tv in tvList {
                storeItemList.append(tv.toStoreItem())
            }
            completion(storeItemList)
        })
    }
}
