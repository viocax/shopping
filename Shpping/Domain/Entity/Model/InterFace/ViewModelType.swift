//
//  ViewModelType.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/23.
//

import Foundation

protocol ViewModelType {

    associatedtype Input
    associatedtype Output

    func transform(_ input: Input) -> Output

}
