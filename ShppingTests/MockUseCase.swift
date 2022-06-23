//
//  MockUseCase.swift
//  ShppingTests
//
//  Created by Jie liang Huang on 2022/6/23.
//

import XCTest
@testable import Shpping
@testable import RxSwift

typealias UseCase = ProductListUseCase

class MockUseCase:  UseCase {
    var injectGetShoppingList: [Observable<[DateConvertable & ProductListCellViewModel]>] = []
    func getShoppingList() -> Observable<[DateConvertable & ProductListCellViewModel]> {
        if !injectGetShoppingList.isEmpty {
            return injectGetShoppingList.removeFirst()
        }
        XCTFail()
        return .empty()
    }
    var injectRestePageCount: Observable<Void> = .empty()
    func resetPageCount() -> Observable<Void> {
        return injectRestePageCount
    }
    var injectPlusCount: Observable<Void> = .empty()
    func plusPage() -> Observable<Void> {
        return injectPlusCount
    }
}
