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
