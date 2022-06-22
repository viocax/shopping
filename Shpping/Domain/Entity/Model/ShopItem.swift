//
//  ShopItem.swift
//  MVVMC
//
//  Created by Jie liang Huang on 2022/6/22.
//

import Foundation

struct ShopItem {
    var name: String
    var description: String
    var price: Int
    var createTime: TimeInterval
    var picture: String
}

// MARK: Codable
extension ShopItem: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = (try? container.decode(String.self, forKey: .name)) ?? ""
        self.description = (try? container.decode(String.self, forKey: .description)) ?? ""
        self.price = (try? container.decode(Int.self, forKey: .price)) ?? 0
        self.createTime = (try? container.decode(TimeInterval.self, forKey: .createTime)) ?? 0
        self.picture = (try? container.decode(String.self, forKey: .picture)) ?? ""
    }
}

