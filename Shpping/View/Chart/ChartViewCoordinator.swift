//
//  ChartViewCoordinator.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/23.
//

import RxSwift

protocol ChartViewCoordinatorProtocol {
    func showOrderView(models: [ShopItemsViewModel]) -> Observable<Void>
}

final class ChartViewCoordinator {
    weak var viewController: ChartViewController?
}

// MARK: ChartViewCoordinatorProtocol
extension ChartViewCoordinator: ChartViewCoordinatorProtocol {
    func showOrderView(models: [ShopItemsViewModel]) -> Observable<Void> {
        return .empty()
    }
}
