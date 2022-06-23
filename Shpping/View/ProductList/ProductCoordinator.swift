//
//  ProductCoordinator.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/23.
//

import Foundation
import RxSwift

protocol ProductCoordinatorProcotol {
    func showDetailPage(_ model: ShopItemsViewModel) -> Observable<Void>
}

final class ProductCoordinator {
    weak var viewCotroller: ProductListViewController?
}

extension ProductCoordinator: ProductCoordinatorProcotol {
    func showDetailPage(_ model: ShopItemsViewModel) -> Observable<Void> {
        return .create { [weak self] subscriber in
            guard let viewController = self?.viewCotroller else {
                subscriber.onCompleted()
                return Disposables.create()
            }
            let useCase = Domain.ProductDetail(model: model)
            let coordinator = ProductDetailCoordinator()
            let viewModel = ProductDetailViewModel(useCase: useCase, coordinator: coordinator)
            let detailView = ProductDetailViewController(viewModel)
            coordinator.viewController = detailView
            viewController.navigationController?.pushViewController(detailView, animated: true)
            subscriber.onNext(())
            subscriber.onCompleted()
            return Disposables.create()
        }
    }
}
