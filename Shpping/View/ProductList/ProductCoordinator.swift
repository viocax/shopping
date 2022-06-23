//
//  ProductCoordinator.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/23.
//

import Foundation
import class RxSwift.Observable

protocol ProductCoordinatorProcotol {
    func showDetailPage(_ model: ProductListCellViewModel) -> Observable<Void>
}
