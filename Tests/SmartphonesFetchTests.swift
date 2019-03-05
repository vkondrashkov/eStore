//
//  SmartphonesFetchTests.swift
//  Tests
//
//  Created by Vladislav Kondrashkov on 3/4/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import XCTest
@testable import eStore

class SmartphonesFetchTests: XCTestCase {
    private var manager: GoodsManager!

    override func setUp() {
        super.setUp()
        manager = GoodsManagerImpl()
    }

    override func tearDown() {
        manager = nil
        super.tearDown()
    }

    func testSeveralItems() {
        // Given
        let json = "[{ \"id\": \"3571539fcbe330452d4d938502ed9f15\", \"brand\": \"Apple\", \"name\": \"iPhone 7 128GB Black\", \"operatingSystem\": \"iOS\", \"display\": { \"width\": 750, \"height\": 1334 }, \"ram\": \"2 GB\", \"flashMemory\": \"128 GB\", \"processor\": \"Apple A10 Fusion\", \"color\": \"Black\", \"batteryCapacity\": 1960, \"price\": 1389, \"stockCount\": 12 }, { \"id\": \"1192ee0cfbc6d237211c9c3b45423260\", \"brand\": \"Apple\", \"name\": \"iPhone 7 32GB Rose Gold\", \"operatingSystem\": \"iOS\", \"display\": { \"width\": 750, \"height\": 1334 }, \"ram\": \"2 GB\", \"flashMemory\": \"32 GB\", \"processor\": \"Apple A10 Fusion\", \"color\": \"Rose Gold\", \"batteryCapacity\": 1960, \"price\": 1190, \"stockCount\": 18 }, { \"id\": \"3571539fcbe330452d4d938502ed9f15\", \"brand\": \"Samsung\", \"name\": \"Galaxy S10+ G975 8GB/128GB Dual Sim Exynos 9820 Onyx\", \"operatingSystem\": \"Android\", \"display\": { \"width\": 1440, \"height\": 3040 }, \"ram\": \"8 GB\", \"flashMemory\": \"128 GB\", \"processor\": \"Exynos 9820\", \"color\": \"Onyx\", \"batteryCapacity\": 4100, \"price\": 2549, \"stockCount\": 3 } ]"

        // When
        manager.fetchSmartphones(from: json, completion: { smartphones in
            // Then
            let expectedResult: [Smartphone]? = [
                Smartphone(
                    id: "3571539fcbe330452d4d938502ed9f15",
                    name: "iPhone 7 128GB Black",
                    brand: "Apple",
                    operatingSystem: .iOS,
                    display: Display(width: 750, height: 1334),
                    ram: "2 GB",
                    flashMemory: "128 GB",
                    processor: "Apple A10 Fusion",
                    color: "Black",
                    batteryCapacity: 1960,
                    price: 1389
                ),
                Smartphone(
                    id: "1192ee0cfbc6d237211c9c3b45423260",
                    name: "iPhone 7 32GB Rose Gold",
                    brand: "Apple",
                    operatingSystem: .iOS,
                    display: Display(width: 750, height: 1334),
                    ram: "2 GB",
                    flashMemory: "32 GB",
                    processor: "Apple A10 Fusion",
                    color: "Rose Gold",
                    batteryCapacity: 1960,
                    price: 1190
                ),
                Smartphone(
                    id: "3571539fcbe330452d4d938502ed9f15",
                    name: "Galaxy S10+ G975 8GB/128GB Dual Sim Exynos 9820 Onyx",
                    brand: "Samsung",
                    operatingSystem: .Android,
                    display: Display(width: 1440, height: 3040),
                    ram: "8 GB",
                    flashMemory: "128 GB",
                    processor: "Exynos 9820",
                    color: "Onyx",
                    batteryCapacity: 4100,
                    price: 2549
                )
            ]
            XCTAssertEqual(smartphones, expectedResult)
        })
    }

    func testWrongJson() {
        // Given
        let json = "[ { \"id\": \"wrong\", \"name\": \"json\" }]"

        // When
        manager.fetchSmartphones(from: json, completion: { smartphones in
            // Then
            XCTAssertEqual(smartphones, nil)
        })
    }

    func testPartlyWrongJson() {
        // Given
        let json = "[{ \"id\": \"3571539fcbe330452d4d938502ed9f15\", \"brand\": \"Apple\", \"name\": \"iPhone 7 128GB Black\", \"operatingSystem\": \"iOS\", \"display\": { \"width\": 750, \"height\": 1334 }, \"ram\": \"2 GB\", \"flashMemory\": \"128 GB\", \"processor\": \"Apple A10 Fusion\", \"color\": \"Black\", \"batteryCapacity\": 1960, \"price\": 1389, \"stockCount\": 12 }, { \"id\": \"wrong\", \"name\": \"json\" } ]"

        // When
        manager.fetchSmartphones(from: json, completion: { smartphones in
            // Then
            let expectedResult: [Smartphone]? = [
                Smartphone(
                    id: "3571539fcbe330452d4d938502ed9f15",
                    name: "iPhone 7 128GB Black",
                    brand: "Apple",
                    operatingSystem: .iOS,
                    display: Display(width: 750, height: 1334),
                    ram: "2 GB",
                    flashMemory: "128 GB",
                    processor: "Apple A10 Fusion",
                    color: "Black",
                    batteryCapacity: 1960,
                    price: 1389
                )
            ]
            XCTAssertEqual(smartphones, expectedResult)
        })
    }

}
