//
//  LaptopsFetchTests.swift
//  Tests
//
//  Created by Vladislav Kondrashkov on 3/4/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import XCTest
@testable import eStore

class LaptopsFetchTests: XCTestCase {
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
        let json = "[{ \"id\": \"34ec91a46a12a40fc44c414b61b638e6\", \"brand\": \"Apple\", \"name\": \"MacBook Air 13\'\' (2017 год) [MQD32]\", \"operatingSystem\": \"MacOs\", \"display\": { \"width\": 1440, \"height\": 900 }, \"processor\": \"Intel Core i5 5350U\", \"price\": 2129, \"stockCount\": 6 }, { \"id\": \"c584ce7e3117e3563b1bf0450844d459\", \"brand\": \"Xiaomi\", \"name\": \"Mi Notebook Pro 15.6 JYU4036CN\", \"operatingSystem\": \"Windows\", \"display\": { \"width\": 1920, \"height\": 1080 }, \"processor\": \"Intel Core i5 8250U\", \"price\": 2202, \"stockCount\": 2 }]"

        // When
        manager.fetchLaptops(from: json, completion: { laptops in
            // Then
            let expectedResult: [Laptop]? = [
                Laptop(
                    id: "34ec91a46a12a40fc44c414b61b638e6",
                    name: "MacBook Air 13\'\' (2017 год) [MQD32]",
                    brand: "Apple",
                    operatingSystem: .MacOs,
                    display: Display(width: 1440, height: 900),
                    processor: "Intel Core i5 5350U",
                    price: 2129
                ),
                Laptop(
                    id: "c584ce7e3117e3563b1bf0450844d459",
                    name: "Mi Notebook Pro 15.6 JYU4036CN",
                    brand: "Xiaomi",
                    operatingSystem: .Windows,
                    display: Display(width: 1920, height: 1080),
                    processor: "Intel Core i5 8250U",
                    price: 2202
                )
            ]
            XCTAssertEqual(laptops, expectedResult)
        })
    }

    func testWrongJson() {
        // Given
        let json = "[ { \"id\": \"wrong\", \"name\": \"json\" }]"

        // When
        manager.fetchLaptops(from: json, completion: { smartphones in
            // Then
            XCTAssertEqual(smartphones, nil)
        })
    }

    func testPartlyWrongJson() {
        // Given
        let json = "[{ \"id\": \"34ec91a46a12a40fc44c414b61b638e6\", \"brand\": \"Apple\", \"name\": \"MacBook Air 13\'\' (2017 год) [MQD32]\", \"operatingSystem\": \"MacOs\", \"display\": { \"width\": 1440, \"height\": 900 }, \"processor\": \"Intel Core i5 5350U\", \"price\": 2129, \"stockCount\": 6 }, { \"id\": \"wrong\", \"name\": \"json\" }]"

        // When
        manager.fetchLaptops(from: json, completion: { laptops in
            // Then
            let epxectedResult: [Laptop]? = [
                Laptop(
                    id: "34ec91a46a12a40fc44c414b61b638e6",
                    name: "MacBook Air 13\'\' (2017 год) [MQD32]",
                    brand: "Apple",
                    operatingSystem: .MacOs,
                    display: Display(width: 1440, height: 900),
                    processor: "Intel Core i5 5350U",
                    price: 2129
                )
            ]
            XCTAssertEqual(laptops, epxectedResult)
        })
    }
}
