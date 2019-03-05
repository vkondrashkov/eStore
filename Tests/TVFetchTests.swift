//
//  TVFetchTests.swift
//  Tests
//
//  Created by Vladislav Kondrashkov on 3/4/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import XCTest
@testable import eStore

class TVFetchTests: XCTestCase {
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
        let json = "[{ \"id\": \"09af2b066b649bbb8ff54dafca4660fe\", \"brand\": \"Samsung\", \"name\": \"UE43NU7100U\", \"operatingSystem\": \"WebOs\", \"display\": { \"width\": 3840, \"height\": 2160 }, \"price\": 991, \"stockCount\": 6 }, { \"id\": \"1490ab49c5af2773450bc6c017477029\", \"brand\": \"Xiaomi\", \"name\": \"MI TV 4A Pro 43\'\'\", \"operatingSystem\": \"WebOs\", \"display\": { \"width\": 1920, \"height\": 1080 }, \"price\": 858, \"stockCount\": 4 }]"

        // When
        manager.fetchTV(from: json, completion: { tv in
            // Then
            let expectedResult: [TV]? = [
                TV(
                    id: "09af2b066b649bbb8ff54dafca4660fe",
                    name: "UE43NU7100U",
                    brand: "Samsung",
                    display: Display(width: 3840, height: 2160),
                    operatingSystem: .WebOs,
                    price: 991
                ),
                TV(
                    id: "1490ab49c5af2773450bc6c017477029",
                    name: "MI TV 4A Pro 43\'\'",
                    brand: "Xiaomi",
                    display: Display(width: 1920, height: 1080),
                    operatingSystem: .WebOs,
                    price: 858
                )
            ]
            XCTAssertEqual(tv, expectedResult)
        })
    }

    func testWrongJson() {
        // Given
        let json = "[ { \"id\": \"wrong\", \"name\": \"json\" }]"

        // When
        manager.fetchTV(from: json, completion: { tv in
            // Then
            XCTAssertEqual(tv, nil)
        })
    }

    func testPartlyWrongJson() {
        // Given
        let json = "[{ \"id\": \"09af2b066b649bbb8ff54dafca4660fe\", \"brand\": \"Samsung\", \"name\": \"UE43NU7100U\", \"operatingSystem\": \"WebOs\", \"display\": { \"width\": 3840, \"height\": 2160 }, \"price\": 991, \"stockCount\": 6 }, { \"id\": \"wrong\", \"name\": \"json\" }]"

        // When
        manager.fetchTV(from: json, completion: { tv in
            // Then
            let epxectedResult: [TV]? = [
                TV(
                    id: "09af2b066b649bbb8ff54dafca4660fe",
                    name: "UE43NU7100U",
                    brand: "Samsung",
                    display: Display(width: 3840, height: 2160),
                    operatingSystem: .WebOs,
                    price: 991
                )
            ]
            XCTAssertEqual(tv, epxectedResult)
        })
    }
}
