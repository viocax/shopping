//
//  ChartViewModelTests.swift
//  ShppingTests
//
//  Created by Jie liang Huang on 2022/6/23.
//

import XCTest
@testable import Shpping
@testable import RxTest
@testable import RxCocoa
@testable import RxSwift

class ChartViewModelTests: XCTestCase {
    
    class Model: ChartViewCellViewModel {
        var info: ShopItemsViewModel
        var isSelected: Bool = false
        init(id: Int) {
            self.info = MockShopModel(id)
        }
    }
    func test_bindView_and_toggle() {
        let testScheduler = TestScheduler(initialClock: 0)
        let disposeBag = DisposeBag()
        let mockUseCase = MockUseCase()
        let mockCoordinator = MockCoordinator()
        let viewModel = ChartViewModel(useCase: mockUseCase, coordinator: mockCoordinator)
        let triggerBindView = PublishRelay<Void>()
        let triggerTapCell = PublishRelay<ChartViewCellViewModel>()
        let input = ChartViewModel
            .Input(
                bindView: triggerBindView.asDriverOnErrorJustComplete(),
                tapCell: triggerTapCell.asDriverOnErrorJustComplete()
            )
        let mockModels: [ChartViewCellViewModel] = (0...10).map(Model.init)
        mockUseCase.injectCurrnetChartItems = mockModels
        mockUseCase.injectToggleEvent = { model in
            let isContain = mockModels.contains(where: { $0.info.identifier == model.info.identifier })
            XCTAssertTrue(isContain)
        }
        mockUseCase.injectCanCheckOut = { _ in
            return true
        }

        let output = viewModel.transform(input)
        // MARK: trigger UpStream
        let bineView = testScheduler.createColdObservable([
            .next(100, ())
        ])
        bineView.bind(to: triggerBindView)
            .disposed(by: disposeBag)

        let tapCell = testScheduler.createColdObservable([
            .next(200, mockModels[0]),
            .next(300, mockModels[2])
        ])
        tapCell.bind(to: triggerTapCell)
            .disposed(by: disposeBag)

        let expectList: [Recorded<Event<[ChartViewCellViewModel]>>] = [
            .next(100, mockModels)
        ]
        
        let observerList = testScheduler.createObserver([ChartViewCellViewModel].self)
        output.list.drive(observerList)
            .disposed(by: disposeBag)

        let expecIsEnable: [Recorded<Event<Bool>>] = [
            .next(200, true)
        ]
        let observerIsEnable = testScheduler.createObserver(Bool.self)
        output.isEnablePurchase
            .drive(observerIsEnable)
            .disposed(by: disposeBag)
        
        testScheduler.start()

        XCTAssertEqual(expectList.map(\.time), observerList.events.map(\.time))
        XCTAssertEqual(expecIsEnable, observerIsEnable.events)
        
    }
}
