//
//  ProductDetailUseCaseTessts.swift
//  ShppingTests
//
//  Created by Jie liang Huang on 2022/6/23.
//

import XCTest
@testable import Shpping

class ProductDetailUseCaseTessts: XCTestCase {

    func test() {
        let mockModel = MockShopModel(999)
        let mockRepo = MockRepo()
        let useCase = Domain.ProductDetail(model: mockModel, repository: mockRepo)
        let expect = expectation(description: "call addTo chart")
        mockRepo.injectAddToChart = { model in
            XCTAssertEqual(model.identifier, mockModel.identifier)
            expect.fulfill()
        }
        useCase.addToChart(mockModel)
        wait(for: [expect], timeout: 0.1)
    }
}
