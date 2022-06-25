//
//  MockService.swift
//  ShppingTests
//
//  Created by Jie liang Huang on 2022/6/23.
//

import Foundation
@testable import Shpping
@testable import RxSwift

class MockService: NetworkService {
    var injectRequest: Observable<Any> = .empty()
    func request<T: Endpoint>(_ endpoint: T) -> Observable<T.Model> {
        // force unwrapper just only in test
        return injectRequest.compactMap { $0 as? T.Model }
    }
}
