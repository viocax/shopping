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
    init(useCase: ChartUseCase, coordinator: ChartViewCoordinatorProtocol) {
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

        let currentList = input.bindView
            .map { self.useCase.getCurrentChartItems() }

        let isEnable = input.tapCell
            .map(useCase.toggleItems(_:))
            .map {
                return self.useCase
                    .canCheckOut(self.useCase.getCurrentChartItems())
            }.distinctUntilChanged()

        return .init(
            list: currentList,
            isEnablePurchase: isEnable
        )
    }
}


