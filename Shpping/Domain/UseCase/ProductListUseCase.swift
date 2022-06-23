//
//  ProductListUseCase.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/23.
//

import Foundation
import class RxSwift.Observable

protocol ProductListUseCase {
    func resetPageCount() -> Observable<Void>
    func plusPage() -> Observable<Void>
    func getShoppingList() -> Observable<[ProductListCellViewModel & DateConvertable]>
}
