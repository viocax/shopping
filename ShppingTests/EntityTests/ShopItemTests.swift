//
//  ShopItemTests.swift
//  MVVMCTests
//
//  Created by Jie liang Huang on 2022/6/21.
//

import XCTest
@testable import Shpping

class ShopItemTests: XCTestCase {
    func test_decode() {
        let mockDate = Date()
        let decoder = JSONDecoder()
        let okString = """
        {
            "name": "Jie",
            "description": "test 1",
            "createTime": \(mockDate.timeIntervalSince1970),
            "price": 999,
            "picture": "https://random.imagecdn.app/500/150"
        }
        """.utf8
        do {
            let model = try decoder.decode(ShopItem.self, from: .init(okString))
            XCTAssertEqual(model.name, "Jie")
            XCTAssertEqual(model.description, "test 1")
            XCTAssertEqual(model.createTime, mockDate.timeIntervalSince1970)
            XCTAssertEqual(model.price, 999)
            XCTAssertEqual(model.picture, "https://random.imagecdn.app/500/150")
        } catch {
            XCTFail("unexpect \(error.localizedDescription)")
        }
        let failString = """
        {
        
        }
        """.utf8
        do {
            let _ = try decoder.decode(ShopItem.self, from: .init(failString))
        } catch {
            XCTAssertTrue(true, "expect: \(error.localizedDescription)")
        }
    }
}
