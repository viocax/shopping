//
//  RandomImageInfo.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/23.
//

import Foundation
import protocol Kingfisher.Resource

struct RandomImageInfo: Resource {
    var cacheKey: String = UUID().uuidString
    var downloadURL: URL {
        guard let url = URL(string: "https://random.imagecdn.app/500/150") else {
            fatalError("checking")
        }
        return url
    }
}
