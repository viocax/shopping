//
//  DateConvertable.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/23.
//

import Foundation

protocol DateConvertable {
    func toString(by date: Date) -> String
}

extension DateConvertable {
    func toString(by date: Date) -> String {
//        fatalError("test")
        return ""
    }
}

extension Int {
    func formatePrice() -> String {
        guard self > 0 else {
            return "$ --"
        }
        return "$ \(self)"
    }
}
