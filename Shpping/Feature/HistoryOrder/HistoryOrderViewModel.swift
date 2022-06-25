//
//  HistoryOrderViewModel.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/24.
//

import RxCocoa
import RxSwift

final class HistoryOrderViewModel {

    private let useCase: HistoryOrderUseCase
    private let coordinator: HistoryOrderCoordinatorProtocol

    init(useCase: HistoryOrderUseCase, coordinator: HistoryOrderCoordinatorProtocol) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
}

// MARK: ViewModelType
extension HistoryOrderViewModel: ViewModelType {
    struct Input {
        let bindView: Driver<Void>
        let clickClose: Driver<Void>
    }
    struct Output {
        let list: Driver<[ShopItemsViewModel]>
        let isLoading: Driver<Bool>
        let isEmpty: Driver<Bool>
        let configuration: Driver<Void>
    }
    func transform(_ input: Input) -> Output {

        let hudTracker = HUDTracker()

        let list = input.bindView
            .flatMap {
                return self.useCase.getHistoryList()
                    .trackActivity(hudTracker)
                    .asDriverOnErrorJustComplete()
            }

        let isEmpty = list
            .map(\.isEmpty)

        let dimiss = input.clickClose
            .flatMap {
                return self.coordinator.dismiss()
                    .asDriverOnErrorJustComplete()
            }

        let configuration = Driver
            .merge(
                dimiss
            )

        return .init(
            list: list,
            isLoading: hudTracker.asDriver(),
            isEmpty: isEmpty,
            configuration: configuration
        )
    }
}
