//
//  Domain.ProductDetail.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/23.
//

import Foundation

extension Domain {
    class ProductDetail {
        private var model: ShopItemsViewModel
        private let repository: RepositoryProtocol
        init(
            model: ShopItemsViewModel,
            repository: RepositoryProtocol = Repository.shared
        ) {
            self.model = model
            self.repository = repository
        }
    }
}

// MARK: ProductDetailUseCase
extension Domain.ProductDetail: ProductDetailUseCase {
    func addToChart(_ item: ShopItemsViewModel) {
        repository.addToChart(item)
    }
    func getCurrentShopItem() -> ShopItemsViewModel {
        // MARK: 目前這件事僅是為了讓外部可以參考scrollView 可以滑動效果
        let newDescription = (0...30)
            .reduce(model.description, { result, _ -> String in
                return result + model.description
            })
        model.description = newDescription
        return model
    }
}