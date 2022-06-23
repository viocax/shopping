//
//  ProductListViewModelTests.swift
//  ShppingTests
//
//  Created by Jie liang Huang on 2022/6/23.
//

import XCTest
@testable import Shpping
@testable import RxTest
@testable import RxCocoa
@testable import RxSwift


class ProductListViewModelTests: XCTestCase {



    func test_clickProduct() {
        // MARK: Dependency
        let disposeBag = DisposeBag()
        let testScheduler = TestScheduler(initialClock: 0)
        let mockUseCase = MockUseCase()

        // MARK: mock list
        let mockModel: ShopItemsViewModel = MockShopModel(99999)
        let mockCoordinator = MockCoordinator()
        mockCoordinator.injectShowDetailPage = { model in
            XCTAssertEqual(mockModel.identifier, model.identifier)
            return .just(())
        }
        let viewModel = ProductListViewModel(useCase: mockUseCase, coordiantor: mockCoordinator)
        let triggerClick = PublishSubject<ShopItemsViewModel>()
        let input = ProductListViewModel
            .Input(
                viewWillAppear: .empty(),
                pullRefresh: .empty(),
                loadingMore: .empty(),
                clickProduct: triggerClick.asDriverOnErrorJustComplete()
            )
        let output = viewModel.transform(input)
        let click = testScheduler.createColdObservable([
            .next(100, mockModel)
        ])
        let expect: [Recorded<Event<Void>>] = [
            .next(100, ())
        ]

        click.bind(to: triggerClick)
            .disposed(by: disposeBag)
        let observerResult = testScheduler.createObserver(Void.self)
        output.confirguration
            .drive(observerResult)
            .disposed(by: disposeBag)

        testScheduler.start()

        XCTAssertEqual(expect.map(\.time), observerResult.events.map(\.time))
    }

    func test_getList() {
        // MARK: Dependency
        let disposeBag = DisposeBag()
        let testScheduler = TestScheduler(initialClock: 0)
        let mockUseCase = MockUseCase()

        // MARK: mock list
        let mockList = (0...10).map(MockShopModel.init)
        let mockError = ErrorInfo(case: .unspport, message: "test")
        mockUseCase.injectGetShoppingList = [
            .just(mockList),
            .just([]),
            .just(mockList + mockList),
            .error(mockError)
        ]
        mockUseCase.injectPlusCount = .just(())
        mockUseCase.injectRestePageCount = .just(())

        let mockCoordinator = MockCoordinator()
        let viewModel = ProductListViewModel(useCase: mockUseCase, coordiantor: mockCoordinator)
        let triggerViewAppear = PublishSubject<Void>()
        let triggerPullRefresh = PublishSubject<Void>()
        let triggerLoadingMore = PublishSubject<Void>()
        let input = ProductListViewModel
            .Input(
                viewWillAppear: triggerViewAppear.asDriverOnErrorJustComplete(),
                pullRefresh: triggerPullRefresh.asDriverOnErrorJustComplete(),
                loadingMore: triggerLoadingMore.asDriverOnErrorJustComplete(),
                clickProduct: .empty()
            )
        let output = viewModel.transform(input)


        // MARK: Trigger event
        let viewDidAppear = testScheduler.createColdObservable([
            .next(100, ()),
            .next(400, ())
        ])
        viewDidAppear.bind(to: triggerViewAppear)
            .disposed(by: disposeBag)
        let pullRefresh = testScheduler.createColdObservable([
            .next(200, ())
        ])
        pullRefresh.bind(to: triggerPullRefresh)
            .disposed(by: disposeBag)
        let loadingMore = testScheduler.createColdObservable([
            .next(300, ())
        ])
        loadingMore.bind(to: triggerLoadingMore)
            .disposed(by: disposeBag)

        // MARK: obserer result
        let observerIsLoading = testScheduler.createObserver(Bool.self)
        output.isLoading
            .drive(observerIsLoading)
            .disposed(by: disposeBag)
        let observerList = testScheduler.createObserver([DateConvertable & ShopItemsViewModel].self)
        output.list
            .drive(observerList)
            .disposed(by: disposeBag)
        let observerError = testScheduler.createObserver(ErrorInfo.self)
        output.error
            .drive(observerError)
            .disposed(by: disposeBag)
        let observerIsEmpty = testScheduler.createObserver(Bool.self)
        output.isEmpty
            .drive(observerIsEmpty)
            .disposed(by: disposeBag)

        // MARK: Expectaction
        let expectList: [Recorded<Event<[ShopModel]>>] = [
            .next(100, mockList),
            .next(200, []),
            .next(300, mockList + mockList)
        ]
        let expectIsLoading: [Recorded<Event<Bool>>] = [
            .next(0, false),
            .next(100, true),
            .next(100, false),
            .next(200, true),
            .next(200, false),
            .next(300, true),
            .next(300, false),
            .next(400, true),
            .next(400, false)
        ]
        let expectError: [Recorded<Event<ErrorInfo>>] = [
            .next(400, mockError)
        ]
        let expectEmpty: [Recorded<Event<Bool>>] = [
            .next(100, false),
            .next(200, true),
            .next(300, false)
        ]

        testScheduler.start()

        XCTAssertEqual(expectIsLoading, observerIsLoading.events)
        XCTAssertEqual(expectEmpty, observerIsEmpty.events)
        XCTAssertEqual(expectError, observerError.events)
        let expectModels = expectList.compactMap(\.value.element)
        let resultModels = observerList.events.compactMap(\.value.element)
        XCTAssertEqual(expectModels.count, resultModels.count)
        zip(expectModels, resultModels).forEach { expect, result in
            XCTAssertEqual(expect.map(\.identifier), result.map(\.identifier))
        }
    }
}
