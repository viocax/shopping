//
//  Int+String.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/24.
//

import Foundation

extension Int {
    func formatePrice() -> String {
        guard self > 0 else {
            return "$ --"
        }
        return "$ \(self)"
    }
}
