//
//  MockRepo.swift
//  ShppingTests
//
//  Created by Jie liang Huang on 2022/6/23.
//

import XCTest
@testable import Shpping

class MockRepo: RepositoryProtocol {
    var injectCurrnetChart: (() -> ([ShopItemsViewModel]))?
    func getShopItemOfChart() -> [ShopItemsViewModel] {
        return injectCurrnetChart?() ?? []
    }

    var injectRemoveAllChart: (() -> Void)?
    func removeAllChart() {
        injectRemoveAllChart?()
    }
    var injectSaveToHistory: (([ShopItemsViewModel]) -> Void)?
    func saveToHistory(_ items: [ShopItemsViewModel]) {
        injectSaveToHistory?(items)
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
