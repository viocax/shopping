//
//  Coordinator.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/25.
//

import UIKit
import RxSwift

final class Coordinator {
    weak var viewController: UIViewController?
}

// MARK: ProductCoordinatorProcotol
extension Coordinator: ProductCoordinatorProcotol {
    func showDetailPage(_ model: ShopItemsViewModel) -> Observable<Void> {
        return .create { [weak self] subscriber in
            guard let viewController = self?.viewController else {
                subscriber.onCompleted()
                return Disposables.create()
            }
            let useCase = Domain.ProductDetail(model: model)
            let coordinator = Coordinator()
            let viewModel = ProductDetailViewModel(useCase: useCase, coordinator: coordinator)
            let detailView = ProductDetailViewController(viewModel)
            coordinator.viewController = detailView
            viewController.navigationController?.pushViewController(detailView, animated: true)
            subscriber.onNext(())
            subscriber.onCompleted()
            return Disposables.create()
        }
    }
    func showHistoryView() -> Observable<Void> {
        return .create { [weak self] subscriber in
            guard let viewController = self?.viewController else {
                subscriber.onCompleted()
                return Disposables.create()
            }
            let useCase = Domain.HistoryOrder()
            let coordinator = Coordinator()
            let viewModel = HistoryOrderViewModel(useCase: useCase, coordinator: coordinator)
            let history = HistoryOrderViewController(viewModel: viewModel)
            history.modalPresentationStyle = .fullScreen
            coordinator.viewController = history
            viewController.present(history, animated: true, completion: {
                subscriber.onNext(())
                subscriber.onCompleted()
            })
            return Disposables.create()
        }
    }
}

// MARK: ProductDetailCoordinatorProtocol
extension Coordinator: ProductDetailCoordinatorProtocol {
    func showChartView() -> Observable<Void> {
        return .create { [weak self] subscriber in
            guard let navigation = self?.viewController?.navigationController else {
                subscriber.onCompleted()
                return Disposables.create()
            }
            let useCase = Domain.Chart()
            let coordinator = Coordinator()
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
            let coordinator = Coordinator()
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

// MARK: ChartViewCoordinatorProtocol
extension Coordinator: ChartViewCoordinatorProtocol {
    func showOrderView() -> Observable<Void> {
        return .create { [weak self] subscriber in
            guard let navigation = self?.viewController?.navigationController else {
                subscriber.onCompleted()
                return Disposables.create()
            }
            let useCase = Domain.OrderChecking()
            let coordinator = Coordinator()
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

// MARK: OrderChekingCoordinatorProtocol
extension Coordinator: OrderChekingCoordinatorProtocol {
    func showAlert() -> Observable<Void> {
        return .create { [weak self] subscriber in
            guard let viewController = self?.viewController else {
                subscriber.onCompleted()
                return Disposables.create()
            }
            // TODO: 資料抽象
            let alert = UIAlertController(title: "付款成功", message: "請至交易紀錄查看詳細資料", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
                subscriber.onNext(())
                subscriber.onCompleted()
            }
            alert.addAction(okAction)
            viewController.present(alert, animated: true, completion: nil)
            return Disposables.create()
        }
    }
    func popToRoot() -> Observable<Void> {
        return .create { [weak self] subscriber in
            guard let navigation = self?.viewController?.navigationController else {
                subscriber.onCompleted()
                return Disposables.create()
            }
            navigation.popToRootViewController(animated: true)
            subscriber.onNext(())
            subscriber.onCompleted()
            return Disposables.create()
        }
    }
}

// MARK: HistoryOrderCoordinatorProtocol
extension Coordinator: HistoryOrderCoordinatorProtocol {
    func dismiss() -> Observable<Void> {
        return .create { [weak self] subscriber in
            guard let viewController = self?.viewController else {
                subscriber.onCompleted()
                return Disposables.create()
            }
            viewController.dismiss(animated: true) {
                subscriber.onNext(())
                subscriber.onCompleted()
            }
            return Disposables.create()
        }
    }
}
