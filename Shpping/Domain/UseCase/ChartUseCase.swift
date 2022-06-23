//
//  ChartUseCase.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/23.
//

import Foundation

protocol ChartUseCase {
    func getCurrentChartItems() -> [ChartViewCellViewModel]
    func canCheckOut() -> Bool
    func toggleItems(_ cell: ChartViewCellViewModel)
}
