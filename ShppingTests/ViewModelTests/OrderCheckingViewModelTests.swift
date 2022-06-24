//
//  OrderCheckingViewModelTests.swift
//  ShppingTests
//
//  Created by Jie liang Huang on 2022/6/24.
//

import XCTest
@testable import Shpping
@testable import RxTest
@testable import RxCocoa
@testable import RxSwift
@testable import Kingfisher

class OrderCheckingViewModelTests: XCTestCase {

    class Model: ChartViewCellViewModel {
        var id: String
        var image: Resource
        var title: String
        var price: String
        var isSelected: Bool = false
        init(id: Int) {
            let model = MockShopModel(id)
            self.id = model.identifier
            self.image = model.image
            self.title = model.title
            self.price = "\(model.price)"
        }
    }

    func test_click_checkout_popToRoot() {
        // MARK: Dependency
        let disposeBag = DisposeBag()
        let testScheduler = TestScheduler(initialClock: 0)
        let mockUseCase = MockUseCase()
        let mockCoordinator = MockCoordinator()
        let viewModel = OrderCheckingViewModel(useCase: mockUseCase, coordinator: mockCoordinator)
        let triggerClickCheckOut = PublishRelay<Void>()
        let input = OrderCheckingViewModel
            .Input(
                bindView: .empty(),
                clickCheckOut: triggerClickCheckOut.asDriverOnErrorJustComplete()
            )
        mockUseCase.injectCheckOut = .just(())
        let output = viewModel.transform(input)

        let click = testScheduler.createColdObservable([
            .next(200, ()),
            .next(300, ())
        ])
        click.bind(to: triggerClickCheckOut)
            .disposed(by: disposeBag)

        let expectClick: [Recorded<Event<Void>>] = [
            .next(200, ()),
            .next(300, ())
        ]
        
        let observerResult = testScheduler.createObserver(Void.self)
        output.configuration
            .drive(observerResult)
            .disposed(by: disposeBag)

        let expectIsLoading: [Recorded<Event<Bool>>] = [
            .next(0, false),
            .next(200, true),
            .next(200, false),
            .next(300, true),
            .next(300, false)
        ]
        let observerIsLoading = testScheduler.createObserver(Bool.self)
        output.isLoading
            .drive(observerIsLoading)
            .disposed(by: disposeBag)

        testScheduler.start()
        XCTAssertEqual(expectClick.map(\.time), observerResult.events.map(\.time))
        XCTAssertEqual(expectIsLoading, observerIsLoading.events)
    }

    func test_getList_isLoading() {
        // MARK: Dependency
        let disposeBag = DisposeBag()
        let testScheduler = TestScheduler(initialClock: 0)
        let mockUseCase = MockUseCase()
        let mockCoordinator = MockCoordinator()
        let viewModel = OrderCheckingViewModel(useCase: mockUseCase, coordinator: mockCoordinator)
        let triggerBindView = PublishRelay<Void>()
        let input = OrderCheckingViewModel
            .Input(
                bindView: triggerBindView.asDriverOnErrorJustComplete(),
                clickCheckOut: .empty()
            )
        let mockModel: [ChartViewCellViewModel] = (0...10).map(Model.init)
        mockUseCase.injectGetItemsToCheckOut = .just(mockModel)
        let output = viewModel.transform(input)

        let bindview = testScheduler.createColdObservable([
            .next(200, ()),
            .next(300, ())
        ])

        bindview.bind(to: triggerBindView)
            .disposed(by: disposeBag)
        let expectlist: [Recorded<Event<[ChartViewCellViewModel]>>] = [
            .next(200, mockModel),
            .next(300, mockModel)
        ]
        let observerList = testScheduler.createObserver([ChartViewCellViewModel].self)
        output.list
            .drive(observerList)
            .disposed(by: disposeBag)

        let expectIsLoading: [Recorded<Event<Bool>>] = [
            .next(0, false),
            .next(200, true),
            .next(200, false),
            .next(300, true),
            .next(300, false)
        ]
        let observerIsLoading = testScheduler.createObserver(Bool.self)
        output.isLoading
            .drive(observerIsLoading)
            .disposed(by: disposeBag)

        testScheduler.start()
        XCTAssertEqual(expectIsLoading, observerIsLoading.events)
        XCTAssertEqual(
            expectlist.map(\.time),
            observerList.events.map(\.time)
        )

        zip(
            expectlist.compactMap(\.value.element),
            observerList.events.compactMap(\.value.element)
        ).forEach { expect, model in
            XCTAssertEqual(expect.map(\.title), model.map(\.title))
        }
    }
}
