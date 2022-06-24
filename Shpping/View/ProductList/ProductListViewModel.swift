//
//  ProductListViewModel.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/23.
//

import RxCocoa
import RxSwift

final class ProductListViewModel {
    private let coordinator: ProductCoordinatorProcotol
    private let useCase: ProductListUseCase
    init(useCase: ProductListUseCase, coordiantor: ProductCoordinatorProcotol) {
        self.useCase = useCase
        self.coordinator = coordiantor
    }
}

// MARK: ViewModelType
extension ProductListViewModel: ViewModelType {
    struct Input {
        let viewWillAppear: Driver<Void>
        let pullRefresh: Driver<Void>
        let loadingMore: Driver<Void>
        let clickHistory: Driver<Void>
        let clickProduct: Driver<ShopItemsViewModel>
    }
    struct Output {
        let list: Driver<[ShopItemsViewModel]>
        let isLoading: Driver<Bool>
        let isEmpty: Driver<Bool>
        let error: Driver<ErrorInfo>
        let confirguration: Driver<Void>
    }
    func transform(_ input: Input) -> Output {
        let errorTracker = ErrorTracker()
        let hudTracker = HUDTracker()

        let pullRefresh = input.pullRefresh
            .flatMap { _ in
                return self.useCase.resetPageCount()
                    .asDriverOnErrorJustComplete()
            }
        let loadingMore = input.loadingMore
            .flatMap { _ in
                return self.useCase.plusPage()
                    .asDriverOnErrorJustComplete()
            }
        let outputList = Driver
            .merge(
                pullRefresh,
                loadingMore,
                input.viewWillAppear
            )
            .flatMap {
                return self.useCase.getShoppingList()
                    .trackError(errorTracker)
                    .trackActivity(hudTracker)
                    .asDriverOnErrorJustComplete()
            }

        let isEmpty = outputList
            .map(\.isEmpty)
            .distinctUntilChanged()
        
        let toDetailPage = input.clickProduct
            .flatMap { clickedItem in
                return self.coordinator.showDetailPage(clickedItem)
                    .asDriverOnErrorJustComplete()
            }

        let toHistoryPage = input.clickHistory
            .flatMap {
                return self.coordinator.showHistoryView()
                    .asDriverOnErrorJustComplete()
            }

        let configuration = Driver
            .merge(
                toDetailPage,
                toHistoryPage
            )

        return .init(
            list: outputList,
            isLoading: hudTracker.asDriver(),
            isEmpty: isEmpty,
            error: errorTracker.asDriver(),
            confirguration: configuration
        )
    }
}
