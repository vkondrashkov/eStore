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
}
