//
//  File.swift
//  ShppingTests
//
//  Created by Jie liang Huang on 2022/6/23.
//

import Foundation
@testable import Shpping
@testable import RxSwift

typealias Coordinator = ProductCoordinatorProcotol & ProductDetailCoordinatorProtocol

class MockCoordinator: Coordinator  {
    
    var injectShowDetailPage: ((ShopItemsViewModel) -> Observable<Void>)!
    func showDetailPage(_ model: ShopItemsViewModel) -> Observable<Void> {
        return injectShowDetailPage(model)
    }

    var injectShowChartView: Observable<Void> = .empty()
    func showChartView() -> Observable<Void> {
        return injectShowChartView
    }

    var injectOrderCheckingView: ((ShopItemsViewModel) -> Observable<Void>)!
    func showOrderCheckingView(_ model: ShopItemsViewModel) -> Observable<Void> {
        return injectOrderCheckingView(model)
    }
}
