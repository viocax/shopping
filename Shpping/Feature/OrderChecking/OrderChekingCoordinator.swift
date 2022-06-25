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
