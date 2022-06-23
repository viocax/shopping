//
//  ProductListUseCaseTests.swift
//  ShppingTests
//
//  Created by Jie liang Huang on 2022/6/23.
//

import XCTest
@testable import Shpping
@testable import RxBlocking
@testable import RxSwift

class ProductListUseCaseTests: XCTestCase {


    func test_ProductListUseCase() {
        let mockSerivce = MockService()
        let useCase = Domain.ProductList(service: mockSerivce, maxCount: 3)
        XCTAssertEqual(useCase.getCurrentCount(), 1)
        let mockModel = ShopItem(name: "Test", description: "Tew1", price: 999, create_Time: 0, picture: "")
        mockSerivce.injectRequest = .just([mockModel])
        let getListSuccess = useCase.getShoppingList()
            .toBlocking().materialize()
        switch getListSuccess {
        case .completed(let elements):
            XCTAssertEqual(elements.count, 1)
        case .failed:
            XCTFail()
        }
        
        let addThreeTimeResult = useCase.plusPage()
            .concat(useCase.plusPage())
            .concat(useCase.plusPage())
            .toBlocking().materialize()
        switch addThreeTimeResult {
        case .completed:
            XCTAssertEqual(useCase.getCurrentCount(), 4)
        case .failed:
            XCTFail()
        }
        let reset = useCase.resetPageCount()
            .toBlocking().materialize()
        switch reset {
        case .completed:
            XCTAssertEqual(useCase.getCurrentCount(), 1)
        case .failed:
            XCTFail()
        }
    }
}
