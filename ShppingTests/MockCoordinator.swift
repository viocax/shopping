//
//  File.swift
//  ShppingTests
//
//  Created by Jie liang Huang on 2022/6/23.
//

import Foundation
@testable import Shpping
@testable import RxSwift

class MockCoordinator: ProductCoordinatorProcotol {
    
    var injectShowDetailPage: ((ProductListCellViewModel) -> Observable<Void>)!
    func showDetailPage(_ model: ProductListCellViewModel) -> Observable<Void> {
        return injectShowDetailPage(model)
    }
}
