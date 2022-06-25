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
    func showOrderCheckingView() -> Observable<Void>
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
    
    func showOrderCheckingView() -> Observable<Void> {
        return .create { [weak self] subscriber in
            guard let navigation = self?.viewController?.navigationController else {
                subscriber.onCompleted()
                return Disposables.create()
            }
            let useCase = Domain.OrderChecking()
            let coordinator = OrderChekingCoordinator()
            let viewModel = OrderCheckingViewModel(useCase: useCase, coordinator: coordinator)
            let orderCheck = OrderCheckingViewController(viewModel: viewModel)
            coordinator.viewController = orderCheck
            navigation.pushViewController(orderCheck, animated: true)
            subscriber.onNext(())
            subscriber.onCompleted()
            return Disposables.create()
        }
    }
}
