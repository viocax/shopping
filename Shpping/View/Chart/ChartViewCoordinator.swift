//
//  ChartViewCoordinator.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/23.
//

import RxSwift

protocol ChartViewCoordinatorProtocol {
    func showOrderView() -> Observable<Void>
}

final class ChartViewCoordinator {
    weak var viewController: ChartViewController?
}

// MARK: ChartViewCoordinatorProtocol
extension ChartViewCoordinator: ChartViewCoordinatorProtocol {
    func showOrderView() -> Observable<Void> {
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
