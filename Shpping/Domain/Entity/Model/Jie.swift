//
//  Jie.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/23.
//

import Foundation

struct Jie<T> {
    private(set) var base: T
    init(_ base: T) {
        self.base = base
    }
}

protocol JIECompatible {
    associatedtype `Type`
    var jie: Jie<Type> { get }
}

extension JIECompatible {
    var jie: Jie<Self> {
        return Jie(self)
    }
}

extension NSObject: JIECompatible {}

