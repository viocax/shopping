//
//  MockShopModel.swift
//  ShppingTests
//
//  Created by Jie liang Huang on 2022/6/23.
//

import Foundation
@testable import Shpping
@testable import Kingfisher

typealias ShopModel = DateConvertable & ShopItemsViewModel

class MockShopModel: ShopModel {
    var identifier: String = UUID().uuidString
    var title: String = ""
    var description: String = ""
    var price: Int = 999
    var image: Resource = RandomImageInfo(urlString: "")
    var createTime: Date = .init()
    init(_ id: Int) {
        self.title = "Test: \(id)"
    }
}
