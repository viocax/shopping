//
//  Domain.ProductList.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/23.
//

import Foundation
import RxSwift

extension Domain {
    class ProductList {
        private var pageCount: Int = 1
        // MARK: from server will better
        private let maxPage: Int
        private let service: NetworkService
        private var tempList: [DateConvertable & ShopItemsViewModel] = []
        
        init(service: NetworkService = APIService(), maxCount: Int = 5) {
            self.service = service
            self.maxPage = maxCount
        }
    }
}

extension Domain.ProductList: ProductListUseCase {
    func resetPageCount() -> Observable<Void> {
        tempList = []
        return .just(pageCount = 1)
    }

    func plusPage() -> Observable<Void> {
        return .just(pageCount += 1)
    }

    func getShoppingList() -> Observable<[DateConvertable & ShopItemsViewModel]> {
        let currentCount = pageCount
        guard currentCount <= maxPage else {
            return .empty()
        }
        return service.request(ProductListEndpoint())
            .map { [weak self] item -> [DateConvertable & ShopItemsViewModel] in
                let new = item + item + item + item + item + item + item
                let tempNames = ["Dan", "Ben", "Ken", "Jane", "Kylle"]
                let result = new.map { showItem  -> DateConvertable & ShopItemsViewModel  in
                    var copy = showItem
                    copy.identifier = UUID().uuidString + copy.identifier
                    copy.name = "Page: \(currentCount), Name: \(tempNames.randomElement() ?? "")"
                    copy.description = "interger \(currentCount)" + copy.description
                    copy.price = copy.price + [20, 30, 40, 50].randomElement()!
                    return copy
                }
                self?.tempList += result
                return self?.tempList ?? []
            }
    }
    #if DEBUG
    func getCurrentCount() -> Int {
        return pageCount
    }
    #endif
}


