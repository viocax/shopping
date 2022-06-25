//
//  Repository.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/23.
//

import Foundation

protocol RepositoryProtocol: AnyObject {
    func getShopItemOfChart() -> [ShopItemsViewModel]
    func addToChart(_ item: ShopItemsViewModel)

    func removeAllChart()

    var selectKeys: [String] { get set }
    // TODO: 可能是跟server溝通再存入db會比較合適，，這邊為了方便就丟在這
    func getHistory() -> [ShopItemsViewModel]
    func saveToHistory(_ items: [ShopItemsViewModel])
}

class Repository {
    static let shared: Repository = .init()
    private var currentChart: [ShopItemsViewModel] = []
    private var selectedToPurChaseKey: Set<String> = .init()
    private var historyRecord: [ShopItemsViewModel] = []
    private init() { }
}

// MARK: RepositoryProtocol
extension Repository: RepositoryProtocol {
    var selectKeys: [String] {
        get {
            return Array(selectedToPurChaseKey)
        }
        set {
            selectedToPurChaseKey.formUnion(newValue)
        }
    }
    func addToChart(_ item: ShopItemsViewModel) {
        currentChart.append(item)
    }
    func removeAllChart() {
        currentChart.removeAll()
    }
    func getShopItemOfChart() -> [ShopItemsViewModel] {
        return currentChart
    }
    func getHistory() -> [ShopItemsViewModel] {
        return historyRecord
    }
    func saveToHistory(_ items: [ShopItemsViewModel]) {
        historyRecord += items
    }
}
