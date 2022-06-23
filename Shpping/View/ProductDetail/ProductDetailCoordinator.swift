//
//  ProductDetailCoordinator.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/23.
//

import Foundation
import RxSwift

protocol ProductDetailCoordinatorProtocol {
    func showChartView() -> Observable<Void>
    func showOrderCheckingView(_ model: ShopItemsViewModel) -> Observable<Void>
}

final class ProductDetailCoordinator {
    weak var viewController: ProductDetailViewController?
}

extension ProductDetailCoordinator: ProductDetailCoordinatorProtocol {

    func showChartView() -> Observable<Void> {
        return .create { [weak self] subscriber in
            guard let navigation = self?.viewController?.navigationController else {
                subscriber.onCompleted()
                return Disposables.create()
            }
            let useCase = Domain.Chart()
            let coordinator = ChartViewCoordinator()
            let viewModel = ChartViewModel(useCase: useCase, coordinator: coordinator)
            let chartView = ChartViewController(viewModel: viewModel)
            coordinator.viewController = chartView
            navigation.pushViewController(chartView, animated: true)
            subscriber.onNext(())
            subscriber.onCompleted()
            return Disposables.create()
        }
    }
    
    func showOrderCheckingView(_ model: ShopItemsViewModel) -> Observable<Void> {
        return .create { [weak self] subscriber in
            guard let navigation = self?.viewController?.navigationController else {
                subscriber.onCompleted()
                return Disposables.create()
            }
            let orderView = OrderCheckingViewController()
            navigation.pushViewController(orderView, animated: true)
            subscriber.onNext(())
            subscriber.onCompleted()
            return Disposables.create()
        }
    }
}
