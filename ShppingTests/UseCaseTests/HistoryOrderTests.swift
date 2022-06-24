//
//  HistoryOrderTests.swift
//  ShppingTests
//
//  Created by Jie liang Huang on 2022/6/24.
//

import XCTest
@testable import Shpping
@testable import RxBlocking

class HistoryOrderTests: XCTestCase {

    func test_GetHistoryList() {
        let mockRepo = MockRepo()
        let useCase = Domain.HistoryOrder(repository: mockRepo)
        let mockModels: [ShopItemsViewModel] = (0...10).map(MockShopModel.init)
        mockRepo.injectGetHistory = mockModels

        let expetResultList = useCase.getHistoryList()
            .toBlocking().materialize()
        switch expetResultList {
        case .completed(let elements):
            XCTAssertEqual(elements.count, 1)
            zip(mockModels, elements[0]).forEach { mock, result in
                XCTAssertEqual(mock.identifier, result.identifier)
                XCTAssertEqual(mock.createTime, result.createTime)
                XCTAssertEqual(mock.price, result.price)
                XCTAssertEqual(mock.title, result.title)
            }
        case .failed:
            XCTFail()
        }
    }
}
