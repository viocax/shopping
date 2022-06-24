//
//  HistoryOrderUseCase.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/24.
//

import RxSwift

protocol HistoryOrderUseCase {
    func getHistoryList() -> Observable<[ShopItemsViewModel]>
}
