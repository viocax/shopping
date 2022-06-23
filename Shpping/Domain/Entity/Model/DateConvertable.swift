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
