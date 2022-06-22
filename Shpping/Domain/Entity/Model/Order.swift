//
//  Order.swift
//  MVVMC
//
//  Created by Jie liang Huang on 2022/6/22.
//

import Foundation

struct Order {
    var items: [ShopItem]
    var createTime: TimeInterval
    var price: Int
}

// MARK: Codable
extension Order: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.createTime = (try? container.decode(TimeInterval.self, forKey: .createTime)) ?? 0
        self.items = (try? container.decode([ShopItem].self, forKey: .items)) ?? []
        self.price = (try? container.decode(Int.self, forKey: .price)) ?? 0
    }
}
