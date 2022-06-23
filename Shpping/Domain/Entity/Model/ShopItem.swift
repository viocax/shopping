//
//  ShopItem.swift
//  MVVMC
//
//  Created by Jie liang Huang on 2022/6/22.
//

import Foundation
import protocol Kingfisher.Resource

protocol ProductListCellViewModel: AnyObject {
    var identifier: String { get }
    var title: String { get }
    var description: String { get }
    var price: String { get }
    var image: Resource { get }
    var createTime: Date { get }
}

struct ShopItem {
    var identifer: String = UUID().uuidString
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

