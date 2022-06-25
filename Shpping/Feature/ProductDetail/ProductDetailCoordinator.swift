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
    func showOrderCheckingView() -> Observable<Void>
}
