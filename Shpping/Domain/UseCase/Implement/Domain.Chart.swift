//
//  Domain.Chart.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/23.
//

import Foundation
import protocol Kingfisher.Resource

extension Domain {
    class Chart {
        private let repository: RepositoryProtocol
        init(repository: RepositoryProtocol = Repository.shared) {
            self.repository = repository
        }
    }
}

extension Domain.Chart: ChartUseCase {
    private struct WrapShopInfo: ChartViewCellViewModel {
        var id: String
        var image: Resource
        var title: String
        var price: String
        var isSelected: Bool
    }
    func getCurrentChartItems() -> [ChartViewCellViewModel] {
        let selectID = repository.selectKeys
        let dictionary = Dictionary(
            grouping: repository.getShopItemOfChart().enumerated(),
            by: { $0.element.identifier }
        )

        return dictionary
            .reduce([], { current, next -> [(ChartViewCellViewModel, Int)] in
                guard !next.value.isEmpty else {
                    return current
                }
                let count = next.value.count
                let info = next.value[0].element
                let price = "$ \(info.price) * \(count) = \(info.price * count)"
                let isSelected = selectID.contains(next.key)
                let newNext: [(ChartViewCellViewModel, Int)] = [
                    (
                        WrapShopInfo(
                            id: info.identifier,
                            image: info.image,
                            title: info.title,
                            price: price,
                            isSelected: isSelected
                        ),
                        next.value[0].offset
                    )
                ]
                return current + newNext
            })
            .sorted(by: { $0.1 < $1.1 })
            .map(\.0)
    }
    func canCheckOut() -> Bool {
        return !repository.selectKeys.isEmpty
    }
    func toggleItems(_ cell: ChartViewCellViewModel) {
        let isSelect = !cell.isSelected
        let currentSelectID = repository.selectKeys
        if isSelect {
            repository.selectKeys += [cell.id]
        } else {
            guard let index = currentSelectID.firstIndex(of: cell.id) else {
                return
            }
            repository.selectKeys.remove(at: index)
        }
    }
}
