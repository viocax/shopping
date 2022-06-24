//
//  OrderChekingCoordinator.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/24.
//

import RxSwift

protocol OrderChekingCoordinatorProtocol {
    func popToRoot() -> Observable<Void>
}

final class OrderChekingCoordinator {
    weak var viewController: OrderCheckingViewController?
}

// MARK: OrderChekingCoordinatorProtocol
extension OrderChekingCoordinator: OrderChekingCoordinatorProtocol {
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
