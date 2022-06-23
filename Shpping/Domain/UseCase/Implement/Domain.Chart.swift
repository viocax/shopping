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
        private var currentSelectID: [String] = []
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
        let selectID = currentSelectID
        let dictionary = Dictionary(
            grouping: repository.getShopItemOfChart(),
            by: { $0.identifier }
        )
        return dictionary
            .reduce(.init(), { current, next -> [ChartViewCellViewModel] in
                guard !next.value.isEmpty else {
                    return current
                }
                let count = next.value.count
                let info = next.value[0]
                let price = "$ \(info.price) * \(count) = \(info.price * count)"
                let isSelected = selectID.contains(next.key)
                let newNext: [ChartViewCellViewModel] = [
                    WrapShopInfo(
                        id: info.identifier,
                        image: info.image,
                        title: info.title,
                        price: price,
                        isSelected: isSelected
                    )
                ]
                return current + newNext
            })
    }
    func canCheckOut() -> Bool {
        return !currentSelectID.isEmpty
    }
    func toggleItems(_ cell: ChartViewCellViewModel) {
        let isSelect = !cell.isSelected
        if isSelect {
            if !currentSelectID.contains(cell.id) {
                currentSelectID.append(cell.id)
            }
        } else {
            guard let index = currentSelectID.firstIndex(of: cell.id) else {
                return
            }
            currentSelectID.remove(at: index)
        }
    }
}
