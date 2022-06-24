//
//  Domain.HistoryOrder.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/24.
//

import RxSwift

extension Domain {
    class HistoryOrder {
        private let repository: RepositoryProtocol
        init(repository: RepositoryProtocol = Repository.shared) {
            self.repository = repository
        }
    }
}

// MARK: HistoryOrderUseCase
extension Domain.HistoryOrder: HistoryOrderUseCase {
    func getHistoryList() -> Observable<[ShopItemsViewModel]> {
        return .just(repository.getHistory())
    }
}
