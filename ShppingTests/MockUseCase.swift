//
//  MockUseCase.swift
//  ShppingTests
//
//  Created by Jie liang Huang on 2022/6/23.
//

import XCTest
@testable import Shpping
@testable import RxSwift

typealias UseCase = ProductListUseCase & ProductDetailUseCase & ChartUseCase & HistoryOrderUseCase & OrderCheckingUseCase

class MockUseCase: UseCase {

    var injectAddToChart: ((ShopItemsViewModel) -> Void)?
    func addToChart(_ item: ShopItemsViewModel) {
        injectAddToChart?(item)
    }

    var injectGetShoppingList: [Observable<[ShopItemsViewModel]>] = []
    func getShoppingList() -> Observable<[ShopItemsViewModel]> {
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

    var injectToggleEvent: ((ChartViewCellViewModel) -> Void)?
    func toggleItems(_ cell: ChartViewCellViewModel) {
        injectToggleEvent?(cell)
    }
    var injectCurrnetChartItems: [ChartViewCellViewModel] = []
    func getCurrentChartItems() -> [ChartViewCellViewModel] {
        return injectCurrnetChartItems
    }
    var injectCanCheckOut: (() -> Bool)?
    func canCheckOut() -> Bool {
        return injectCanCheckOut?() ?? false
    }

    var injectGetHistoryList: Observable<[ShopItemsViewModel]> = .empty()
    func getHistoryList() -> Observable<[ShopItemsViewModel]> {
        return injectGetHistoryList
    }

    var injectCheckOut: Observable<Void> = .empty()
    func checkOut() -> Observable<Void> {
        return injectCheckOut
    }

    var injectGetItemsToCheckOut: Observable<[OrderCellDisplayModel]> = .empty()
    func getItemsToCheckOut() -> Observable<[OrderCellDisplayModel]> {
        return injectGetItemsToCheckOut
    }
    var injectFooterModel: OrderFooterViewModel?
    func getFooterInfo() -> OrderFooterViewModel {
        return injectFooterModel!
    }
}
