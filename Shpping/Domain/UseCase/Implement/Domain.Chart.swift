//
//  Domain.Chart.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/23.
//

import Foundation

extension Domain {
    class Chart {
    
    }
}

extension Domain.Chart: ChartUseCase {
    func getCurrentChartItems() -> [ChartViewCellViewModel] {
        return []
    }
    func canCheckOut(_ list: [ChartViewCellViewModel]) -> Bool {
        return false
    }
    func toggleItems(_ cell: ChartViewCellViewModel) {
        
    }
}
