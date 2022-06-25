//
//  File.swift
//  ShppingTests
//
//  Created by Jie liang Huang on 2022/6/23.
//

import Foundation
@testable import Shpping
@testable import RxSwift

typealias Coordinator = ProductCoordinatorProcotol & ProductDetailCoordinatorProtocol & ChartViewCoordinatorProtocol & HistoryOrderCoordinatorProtocol & OrderChekingCoordinatorProtocol

class MockCoordinator: Coordinator  {
    
    var injectShowAlert: Observable<Void> = .empty()
    func showAlert() -> Observable<Void> {
        return injectShowAlert
    }
    
    var injectShowDetailPage: ((ShopItemsViewModel) -> Observable<Void>)!
    func showDetailPage(_ model: ShopItemsViewModel) -> Observable<Void> {
        return injectShowDetailPage(model)
    }

    var injectShowChartView: Observable<Void> = .empty()
    func showChartView() -> Observable<Void> {
        return injectShowChartView
    }

    var injectOrderCheckingView: (() -> Observable<Void>)!
    func showOrderCheckingView() -> Observable<Void> {
        return injectOrderCheckingView()
    }

    var injectMoreOrderCheckingView: (() -> Observable<Void>)!
    func showOrderView() -> Observable<Void> {
        return injectMoreOrderCheckingView()
    }

    var injectDismiss: Observable<Void> = .empty()
    func dismiss() -> Observable<Void> {
        return injectDismiss
    }

    var injectShowHistoryView: Observable<Void> = .empty()
    func showHistoryView() -> Observable<Void> {
        return injectShowHistoryView
    }
    
    var injectPopToRoot: Observable<Void> = .empty()
    func popToRoot() -> Observable<Void> {
        return injectPopToRoot
    }
}
