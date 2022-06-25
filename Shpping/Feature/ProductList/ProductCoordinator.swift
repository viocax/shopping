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
    func showHistoryView() -> Observable<Void>
}
