//
//  Repository.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/23.
//

import Foundation

protocol RepositoryProtocol {
    func getShopItemOfChart() -> [ShopItemsViewModel]
    func addToChart(_ item: ShopItemsViewModel)
}

class Repository {
    static let shared: Repository = .init()
    private var currentChart: [ShopItemsViewModel] = []
    private init() { }
}

// MARK: RepositoryProtocol
extension Repository: RepositoryProtocol {
    func addToChart(_ item: ShopItemsViewModel) {
        currentChart.append(item)
    }
    func getShopItemOfChart() -> [ShopItemsViewModel] {
        return currentChart
    }
}
