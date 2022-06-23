//
//  ErrorInfo.swift
//  MVVMC
//
//  Created by Jie liang Huang on 2022/6/22.
//

import Foundation

struct ErrorInfo: Error, Equatable {
    var `case`: ErrorCase
    var message: String
}

enum ErrorCase: Error {
    case decodeError, unspport, pathMissing
}


