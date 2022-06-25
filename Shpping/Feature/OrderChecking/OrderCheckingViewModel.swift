//
//  OrderCheckingViewModel.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/24.
//

import RxSwift
import RxCocoa

final class OrderCheckingViewModel {

    private let useCase: OrderCheckingUseCase
    private let coordinator: OrderChekingCoordinatorProtocol

    init(
        useCase: OrderCheckingUseCase,
        coordinator: OrderChekingCoordinatorProtocol
    ) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
}

// MARK: ViewModeType
extension OrderCheckingViewModel: ViewModelType {
    struct Input {
        let bindView: Driver<Void>
        let clickCheckOut: Driver<Void>
    }
    struct Output {
        let footer: Driver<OrderFooterViewModel>
        let list: Driver<[OrderCellDisplayModel]>
        let isLoading: Driver<Bool>
        let configuration: Driver<Void>
    }
    func transform(_ input: Input) -> Output {

        let hudTracker = HUDTracker()

        let checkOutSuccess = self.coordinator.showAlert()
            .flatMap { self.coordinator.popToRoot() }
            .asDriverOnErrorJustComplete()

        let checkOut = input.clickCheckOut
            .flatMap { _ in
                return self.useCase.checkOut()
                    .trackActivity(hudTracker)
                    .asDriverOnErrorJustComplete()
            }.flatMap { checkOutSuccess }

        let list = input.bindView
            .flatMap {
                return self.useCase.getItemsToCheckOut()
                    .trackActivity(hudTracker)
                    .asDriverOnErrorJustComplete()
            }
        let footer = list
            .map { _ in self.useCase.getFooterInfo() }

        let configuration = Driver
            .merge(
                checkOut
            )

        return .init(
            footer: footer,
            list: list,
            isLoading: hudTracker.asDriver(),
            configuration: configuration
        )
    }
}
