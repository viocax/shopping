//
//  ProductListEndpoint.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/23.
//

import Foundation

struct ProductListEndpoint: Endpoint {
    typealias Model = [ShopItem]
    var path: String { "Product_list" }
}
