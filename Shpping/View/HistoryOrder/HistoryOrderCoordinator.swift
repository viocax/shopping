//
//  HistoryOrderCoordinator.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/24.
//

import RxSwift

protocol HistoryOrderCoordinatorProtocol {
    func dismiss() -> Observable<Void>
}

final class HistoryOrderCoordinator {
    weak var viewController: HistoryOrderViewController?
}

// MARK: HistoryOrderCoordinatorProtocol
extension HistoryOrderCoordinator: HistoryOrderCoordinatorProtocol {
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
