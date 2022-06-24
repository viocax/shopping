//
//  Date+String.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/24.
//

import Foundation

fileprivate struct DateFomat {
    static let formater = DateFormatter()
    static func getSring(_ date: Date) -> String {
        formater.dateFormat = "yyyy-MM-dd"
        return formater.string(from: date)
    }
}

extension Date {
    func toString() -> String {
        return DateFomat.getSring(self)
    }
}
