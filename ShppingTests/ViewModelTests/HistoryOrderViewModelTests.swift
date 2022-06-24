//
//  HistoryOrderViewModelTests.swift
//  ShppingTests
//
//  Created by Jie liang Huang on 2022/6/24.
//

import XCTest
@testable import Shpping
@testable import RxTest
@testable import RxCocoa
@testable import RxSwift

class HistoryOrderViewModelTests: XCTestCase {

    func test_bindView_list_isLoading() {
        let testScheduler = TestScheduler(initialClock: 0)
        let disposeBag = DisposeBag()
        let mockUseCase = MockUseCase()
        let mockCoordinator = MockCoordinator()

        let triggerBindView = PublishRelay<Void>()
        let triggerClocse = PublishRelay<Void>()
        let viewModel = HistoryOrderViewModel(useCase: mockUseCase, coordinator: mockCoordinator)
        let input = HistoryOrderViewModel
            .Input(
                bindView: triggerBindView.asDriverOnErrorJustComplete(),
                clickClose: triggerClocse.asDriverOnErrorJustComplete()
            )
        let ouput = viewModel.transform(input)

        let mockModels = (0...10).map(MockShopModel.init)
        mockUseCase.injectGetHistoryList = .just(mockModels)

        let bindView = testScheduler.createColdObservable([
            .next(100, ())
        ])
        bindView.bind(to: triggerBindView)
            .disposed(by: disposeBag)

        let expect: [Recorded<Event<[ShopItemsViewModel]>>] = [
            .next(100, mockModels)
        ]
        let observerResult = testScheduler.createObserver([ShopItemsViewModel].self)
        ouput.list
            .drive(observerResult)
            .disposed(by: disposeBag)

        let expectIsEmpty: [Recorded<Event<Bool>>] = [
            .next(100, false)
        ]
        let observerIsEmpty = testScheduler.createObserver(Bool.self)
        ouput.isEmpty
            .drive(observerIsEmpty)
            .disposed(by: disposeBag)

        let expectIsLoading: [Recorded<Event<Bool>>] = [
            .next(0, false),
            .next(100, true),
            .next(100, false)
        ]
        let observerIsLoading = testScheduler.createObserver(Bool.self)
        ouput.isLoading
            .drive(observerIsLoading)
            .disposed(by: disposeBag)

        let close = testScheduler.createColdObservable([
            .next(300, ())
        ])
        mockCoordinator.injectDismiss = .just(())
        close.bind(to: triggerClocse)
            .disposed(by: disposeBag)

        let expectClose: [Recorded<Event<Void>>] = [
            .next(300, ())
        ]
        let observerDismiss = testScheduler.createObserver(Void.self)
        ouput.configuration
            .drive(observerDismiss)
            .disposed(by: disposeBag)
        

        testScheduler.start()
        XCTAssertEqual(expectIsEmpty, observerIsEmpty.events)
        XCTAssertEqual(expectIsLoading, observerIsLoading.events)
        XCTAssertEqual(expect.map(\.time), observerResult.events.map(\.time))
        XCTAssertEqual(expectClose.map(\.time), observerDismiss.events.map(\.time))
        zip(
            expect.compactMap(\.value.element),
            observerResult.events.compactMap(\.value.element)
        ).forEach { lModel, rModel in
            XCTAssertEqual(lModel.map(\.identifier), rModel.map(\.identifier))
        }
    }

}
