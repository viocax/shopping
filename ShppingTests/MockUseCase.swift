//
//  MockUseCase.swift
//  ShppingTests
//
//  Created by Jie liang Huang on 2022/6/23.
//

import XCTest
@testable import Shpping
@testable import RxSwift

typealias UseCase = ProductListUseCase & ProductDetailUseCase

class MockUseCase:  UseCase {
    var injectGetShoppingList: [Observable<[DateConvertable & ShopItemsViewModel]>] = []
    func getShoppingList() -> Observable<[DateConvertable & ShopItemsViewModel]> {
        if !injectGetShoppingList.isEmpty {
            return injectGetShoppingList.removeFirst()
        }
        XCTFail()
        return .empty()
    }
    var injectRestePageCount: Observable<Void> = .empty()
    func resetPageCount() -> Observable<Void> {
        return injectRestePageCount
    }
    var injectPlusCount: Observable<Void> = .empty()
    func plusPage() -> Observable<Void> {
        return injectPlusCount
    }

    var injectShopItems: ShopItemsViewModel!
    func getCurrentShopItem() -> ShopItemsViewModel {
        return injectShopItems
    }
}
