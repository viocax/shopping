//
//  MockRepo.swift
//  ShppingTests
//
//  Created by Jie liang Huang on 2022/6/23.
//

import XCTest
@testable import Shpping

class MockRepo: RepositoryProtocol {
    func getShopItemOfChart() -> [ShopItemsViewModel] {
        XCTFail()
        return []
    }

    func removeAllChart() {
        XCTFail()
    }
    func saveToHistory(_ items: [ShopItemsViewModel]) {
        XCTFail()
    }

    var injectGetHistory: [ShopItemsViewModel] = []
    func getHistory() -> [ShopItemsViewModel] {
        return injectGetHistory
    }
    var injectAddToChart: ((ShopItemsViewModel) -> Void)?
    func addToChart(_ item: ShopItemsViewModel) {
        injectAddToChart?(item)
    }
}
