//
//  OrderCheckingUseCase.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/24.
//

import RxSwift

protocol OrderCheckingUseCase {
    func checkOut() -> Observable<Void>
    func getItemsToCheckOut() -> Observable<[OrderCellDisplayModel]>
    func getFooterInfo(_ allItems: [OrderCellDisplayModel]) -> OrderCellDisplayModel
}
