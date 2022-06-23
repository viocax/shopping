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
        return .empty()
    }
    
    func showOrderCheckingView(_ model: ShopItemsViewModel) -> Observable<Void> {
        return .empty()
    }
}
