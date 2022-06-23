//
//  ShopItem.swift
//  MVVMC
//
//  Created by Jie liang Huang on 2022/6/22.
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

struct ShopItem {
    var identifier: String = UUID().uuidString
    var name: String
    var description: String
    var price: Int
    var create_Time: TimeInterval
    var picture: String
}

// MARK: Codable
extension ShopItem: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = (try? container.decode(String.self, forKey: .name)) ?? ""
        self.description = (try? container.decode(String.self, forKey: .description)) ?? ""
        self.price = (try? container.decode(Int.self, forKey: .price)) ?? 0
        self.create_Time = (try? container.decode(TimeInterval.self, forKey: .create_Time)) ?? 0
        self.picture = (try? container.decode(String.self, forKey: .picture)) ?? ""
    }
}


extension ShopItem: ShopItemsViewModel, DateConvertable {
    var title: String {
        return self.name
    }

    var image: Resource {
        return RandomImageInfo(urlString: picture, identifier)
    }
    
    var createTime: Date {
        return Date(timeIntervalSince1970: self.create_Time)
    }
}
