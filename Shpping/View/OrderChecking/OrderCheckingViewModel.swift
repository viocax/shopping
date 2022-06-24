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
        let list: Driver<[ChartViewCellViewModel]>
        let isLoading: Driver<Bool>
        let error: Driver<ErrorInfo>
        let configuration: Driver<Void>
    }
    func transform(_ input: Input) -> Output {

        return .init(
            list: .empty(),
            isLoading: .empty(),
            error: .empty(),
            configuration: .empty()
        )
    }
}
