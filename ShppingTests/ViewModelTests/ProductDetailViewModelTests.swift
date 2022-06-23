//
//  ProductDetailViewModelTests.swift
//  ShppingTests
//
//  Created by Jie liang Huang on 2022/6/23.
//

import XCTest
@testable import Shpping
@testable import RxTest
@testable import RxCocoa
@testable import RxSwift

class ProductDetailViewModelTests: XCTestCase {
    

    func test_showData_clickEvent() {
        let testScheduler = TestScheduler(initialClock: 0)
        let disposeBag = DisposeBag()
        let mockUseCase = MockUseCase()
        let mockCoordinator = MockCoordinator()
        let viewModel = ProductDetailViewModel(useCase: mockUseCase, coordinator: mockCoordinator)

        let triggerBindView = PublishRelay<Void>()
        let triggerClickPurchase = PublishRelay<Void>()
        let triggerAddToChat = PublishRelay<Void>()
        let input = ProductDetailViewModel
            .Input(
                addToChat: triggerAddToChat.asDriverOnErrorJustComplete(),
                purchase: triggerClickPurchase.asDriverOnErrorJustComplete(),
                bindView: triggerBindView.asDriverOnErrorJustComplete()
            )
        let output = viewModel.transform(input)

        let mockModel = MockShopModel(999)
        mockUseCase.injectShopItems = mockModel

        // MARK: Bind view event
        let bindView = testScheduler.createColdObservable([
            .next(100, ())
        ])
        bindView.bind(to: triggerBindView)
            .disposed(by: disposeBag)
        let expectModel: [Recorded<Event<ShopItemsViewModel>>] = [
            .next(100, mockModel)
        ]
        let observerModel = testScheduler.createObserver(ShopItemsViewModel.self)
        output.displayModel
            .drive(observerModel)
            .disposed(by: disposeBag)

        // MARK: Click purchase
        let clickPurchase = testScheduler.createColdObservable([
            .next(200, ())
        ])
        clickPurchase.bind(to: triggerClickPurchase)
            .disposed(by: disposeBag)
        let expectPurchase: [Recorded<Event<Void>>] = [
            .next(200, ())
        ]
        mockCoordinator.injectOrderCheckingView = { model in
            XCTAssertEqual(model.identifier, mockModel.identifier)
            return .just(())
        }

        // MARK: add chart
        let clickChart = testScheduler.createColdObservable([
            .next(300, ())
        ])
        clickChart.bind(to: triggerAddToChat)
            .disposed(by: disposeBag)
        let expectChart: [Recorded<Event<Void>>] = [
            .next(300, ())
        ]
        mockCoordinator.injectShowChartView = .just(())

        let observerResult = testScheduler.createObserver(Void.self)
        output.configuration
            .drive(observerResult)
            .disposed(by: disposeBag)
        

        testScheduler.start()

        // MARK: compare `output.displayModel`
        XCTAssertEqual(expectModel.map(\.time), observerModel.events.map(\.time))
        let expectModels = expectModel.compactMap(\.value.element)
        let resultModels = observerModel.events.compactMap(\.value.element)
        XCTAssertEqual(expectModels.count, resultModels.count)
        zip(expectModels, resultModels).forEach { expect, result in
            XCTAssertEqual(expect.identifier, result.identifier)
        }
        XCTAssertEqual((expectPurchase + expectChart).map(\.time), observerResult.events.map(\.time))
    }
}
