//
//  OrderCheckingUseCaseTests.swift
//  ShppingTests
//
//  Created by Jie liang Huang on 2022/6/24.
//

import XCTest
@testable import Shpping
@testable import RxBlocking
@testable import RxSwift
@testable import Kingfisher

class OrderCheckingUseCaseTests: XCTestCase {

    func test_getfooterInfo() {
        let mockRepo = MockRepo()
        let useCase = Domain.OrderChecking(repository: mockRepo)
        let mockModel = (1...4).map(MockShopModel.init)
            .enumerated()
            .map { (offset, item) -> MockShopModel in
                let copy = item
                copy.price = 10 * offset
                return copy
            }
        let expectPrice = mockModel.reduce(.zero, { $0 + $1.price })
        let expect = expectation(description: "call getCurrent chart")
        mockRepo.injectCurrnetChart = {
            expect.fulfill()
            return mockModel
        }
        let result = useCase.getFooterInfo()
        XCTAssertEqual("總共金額:$\(expectPrice)", result.priceString)
        XCTAssertEqual("您的購物袋符合棉額外付費運送服務資格\n分期付款僅於購買單件商品提供。請注意，行動支付僅支持全額付款。\n欲享有多種分期付款方式請至實體門市消費。", result.content)
        wait(for: [expect], timeout: 0.1)
    }

    func test_getList() {
        let mockRepo = MockRepo()
        let useCase = Domain.OrderChecking(repository: mockRepo)
        let mockModels = (1...4).map(MockShopModel.init)
        let expectCall = expectation(description: "call get current chart")
        mockRepo.injectCurrnetChart = {
            expectCall.fulfill()
            return mockModels
        }
        let result = useCase.getItemsToCheckOut()
            .toBlocking().materialize()
        switch result {
        case let .completed(elements):
            XCTAssertEqual(elements.count, 1)
            let ids = mockModels.map(\.identifier)
            let titles = mockModels.map(\.title)
            elements[0].forEach { resultModel in
                XCTAssertTrue(ids.contains(resultModel.id))
                XCTAssertTrue(titles.contains(resultModel.title))
            }
        case .failed:
            break
        }
        wait(for: [expectCall], timeout: 0.1)
    }

    func test_checkOut() {
        let mockRepo = MockRepo()
        let useCase = Domain.OrderChecking(repository: mockRepo)
        let mockModels = (1...4).map(MockShopModel.init)
        let expectCallSave = expectation(description: "call save to history list")
        let expectCallGetCurrnetChart = expectation(description: "call getCurrentChart")
        let expectCallRemoveAllChart = expectation(description: "call remove all Chart")
        mockRepo.injectCurrnetChart = {
            expectCallGetCurrnetChart.fulfill()
            return mockModels
        }
        mockRepo.injectSaveToHistory = { list in
            expectCallSave.fulfill()
            zip(mockModels, list)
                .forEach { mock, result in
                    XCTAssertEqual(mock.price, result.price)
                    XCTAssertEqual(mock.title, result.title)
                    XCTAssertEqual(mock.identifier, result.identifier)
                    XCTAssertEqual(mock.description, result.description)
                    XCTAssertEqual(mock.createTime, result.createTime)
                }
        }
        mockRepo.injectRemoveAllChart = {
            expectCallRemoveAllChart.fulfill()
        }
        let callCheckOut = useCase.checkOut().toBlocking().materialize()
        switch callCheckOut {
        case .completed:
            wait(
                for: [
                    expectCallSave,
                    expectCallGetCurrnetChart,
                    expectCallRemoveAllChart
                ],
                timeout: 0.1
            )
        default:
            XCTFail("unexpect, test case fail")
        }
    }
}
