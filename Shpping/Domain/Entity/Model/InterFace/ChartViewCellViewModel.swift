//
//  ChartViewCellViewModel.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/24.
//

import Foundation
import protocol Kingfisher.Resource

protocol Selectable {
    var isSelected: Bool { get set }
}

protocol OrderCellDisplayModel {
    var id: String { get }
    var image: Resource { get }
    var title: String { get }
    var price: String { get }
}

typealias ChartViewCellViewModel = OrderCellDisplayModel & Selectable
