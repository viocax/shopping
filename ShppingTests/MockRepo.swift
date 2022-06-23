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
    
    var injectAddToChart: ((ShopItemsViewModel) -> Void)?
    func addToChart(_ item: ShopItemsViewModel) {
        injectAddToChart?(item)
    }
}
