//
//  RandomImageInfo.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/23.
//

import Foundation
import protocol Kingfisher.Resource

struct RandomImageInfo: Resource {
    var cacheKey: String
    private let urlString: String
    var downloadURL: URL {
        guard let url = URL(string: urlString) else {
            fatalError("checking")
        }
        return url
    }
    init(urlString: String, _ key: String = UUID().uuidString) {
        self.cacheKey = key
        self.urlString = urlString.isEmpty ? "https://random.imagecdn.app/500/150" : urlString
    }
}
