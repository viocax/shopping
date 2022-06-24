//
//  ShopItemsViewModel.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/24.
//

import Foundation
import protocol Kingfisher.Resource

protocol ShopItemsViewModel {
    var identifier: String { get set }
    var title: String { get }
    var description: String { get set }
    var price: Int { get }
    var image: Resource { get }
    var createTime: Date { get }
}
