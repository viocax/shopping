//
//  OrderTests.swift
//  MVVMCTests
//
//  Created by Jie liang Huang on 2022/6/21.
//

import XCTest
@testable import Shpping

class OrderTests: XCTestCase {

    func test_decode() {
        let mockDate = Date()
        let decoder = JSONDecoder()
        let string = """
        {
            "items": [
                {
                    "name": "Jie",
                    "description": "test 1",
                    "create_Time": \(mockDate.timeIntervalSince1970),
                    "price": 999,
                    "picture": "https://random.imagecdn.app/500/150"
                }
            ],
            "createTime": \(mockDate.timeIntervalSince1970),
            "price": 88
        }
        """.utf8
        do {
            let model = try decoder.decode(Order.self, from: .init(string))
            XCTAssertEqual(model.price, 88)
            XCTAssertEqual(model.createTime, mockDate.timeIntervalSince1970)
            XCTAssertEqual(model.items.count, 1)
            XCTAssertEqual(model.items[0].description, "test 1")
            XCTAssertEqual(model.items[0].create_Time, mockDate.timeIntervalSince1970)
            XCTAssertEqual(model.items[0].price, 999)
            XCTAssertEqual(model.items[0].picture, "https://random.imagecdn.app/500/150")
        } catch {
            XCTFail("unexpect")
        }
        let emptyString = """
        {}
        """.utf8
        do {
            let _ = try decoder.decode(Order.self, from: .init(emptyString))
        } catch {
            XCTAssertTrue(true, "expect: \(error.localizedDescription)")
        }
    }
}
