//
//  ProductDetailViewModel.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/23.
//

import RxSwift
import RxCocoa

final class ProductDetailViewModel {
    private let useCase: ProductDetailUseCase
    private let coordinator: ProductDetailCoordinatorProtocol

    init(
        useCase: ProductDetailUseCase,
        coordinator: ProductDetailCoordinatorProtocol
    ) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
}

extension ProductDetailViewModel: ViewModelType {
    struct Input {
        let addToChat: Driver<Void>
        let purchase: Driver<Void>
        let bindView: Driver<Void>
    }
    struct Output {
        let configuration: Driver<Void>
        let displayModel: Driver<ShopItemsViewModel>
    }
    func transform(_ input: Input) -> Output {
        let displayModel = input.bindView
            .map { self.useCase.getCurrentShopItem() }

        let gotoChartView = input.addToChat
            .withLatestFrom(displayModel)
            .map(useCase.addToChart(_:))
            .flatMap {
                return self.coordinator.showChartView()
                    .asDriverOnErrorJustComplete()
            }

        let gotoOrderView = input.purchase
            .withLatestFrom(displayModel)
            .flatMap { item in
                return self.coordinator.showOrderCheckingView(item)
                    .asDriverOnErrorJustComplete()
            }

        let configuration = Driver
            .merge(
                gotoChartView,
                gotoOrderView
            )

        return .init(
            configuration: configuration,
            displayModel: displayModel
        )
    }
}
