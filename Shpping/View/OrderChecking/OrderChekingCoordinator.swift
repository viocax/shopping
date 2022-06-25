//
//  OrderChekingCoordinator.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/24.
//

import RxSwift

protocol OrderChekingCoordinatorProtocol {
    func showAlert() -> Observable<Void>
    func popToRoot() -> Observable<Void>
}

final class OrderChekingCoordinator {
    weak var viewController: OrderCheckingViewController?
}

// MARK: OrderChekingCoordinatorProtocol
extension OrderChekingCoordinator: OrderChekingCoordinatorProtocol {
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
