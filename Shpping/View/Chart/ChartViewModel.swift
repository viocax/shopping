//
//  ChartViewModel.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/23.
//

import RxSwift
import RxCocoa

final class ChartViewModel {
    private let useCase: ChartUseCase
    private let coordinator: ChartViewCoordinatorProtocol

    init(
        useCase: ChartUseCase,
        coordinator: ChartViewCoordinatorProtocol
    ) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
}

extension ChartViewModel: ViewModelType {
    struct Input {
        let bindView: Driver<Void>
        let tapCell: Driver<ChartViewCellViewModel>
    }
    struct Output {
        let list: Driver<[ChartViewCellViewModel]>
        let isEnablePurchase: Driver<Bool>
    }
    func transform(_ input: Input) -> Output {

        let initalList = input.bindView
            .map { self.useCase.getCurrentChartItems() }

        let toggle = input.tapCell
            .map(useCase.toggleItems(_:))
            .map { self.useCase.getCurrentChartItems() }

        let list = Driver
            .merge(
                initalList,
                toggle
            )
        
        let isEnable = Driver
            .merge(
                input.bindView,
                toggle.map { _ in }
            )
            .map { _ in self.useCase.canCheckOut() }
            .distinctUntilChanged()

        return .init(
            list: list,
            isEnablePurchase: isEnable
        )
    }
}


