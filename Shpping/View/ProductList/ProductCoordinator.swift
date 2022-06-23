//
//  ProductCoordinator.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/23.
//

import Foundation
import RxSwift

protocol ProductCoordinatorProcotol {
    func showDetailPage(_ model: ProductListCellViewModel) -> Observable<Void>
}

final class ProductCoordinator {
    weak var viewCotroller: ProductListViewController?
}

extension ProductCoordinator: ProductCoordinatorProcotol {
    func showDetailPage(_ model: ProductListCellViewModel) -> Observable<Void> {
        return .create { [weak self] subscriber in
            guard let viewController = self?.viewCotroller else {
                subscriber.onCompleted()
                return Disposables.create()
            }
            let detailView = ProductDetailViewController()
            viewController.navigationController?.pushViewController(detailView, animated: true)
            subscriber.onNext(())
            subscriber.onCompleted()
            return Disposables.create()
        }
    }
}
