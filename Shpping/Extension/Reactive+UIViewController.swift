//
//  Reactive+UIViewController.swift
//  Homework
//
//  Created by Jie liang Huang on 2022/6/23.
//

import RxSwift
import UIKit
import RxCocoa

extension Reactive where Base: UIViewController {
    var viewWillAppear: ControlEvent<Void> {
        let source = methodInvoked(#selector(Base.viewWillAppear(_:))).mapToVoid()
        return ControlEvent(events: source)
    }
    var viewWillDisAppear: ControlEvent<Void> {
        let source = methodInvoked(#selector(Base.viewWillDisappear(_:))).mapToVoid()
        return ControlEvent(events: source)
    }
    var viewDidAppear: ControlEvent<Void> {
        let source = methodInvoked(#selector(Base.viewDidAppear(_:))).mapToVoid()
        return ControlEvent(events: source)
    }
    var viewDidDisAppear: ControlEvent<Void> {
        let source = methodInvoked(#selector(Base.viewDidDisappear(_:))).mapToVoid()
        return ControlEvent(events: source)
    }
}

extension ObservableType {
    // MARK: Just for unwrapped Observable Type easily
    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
    // MARK: catch Error send complection Event
    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { _ in
            return .empty()
        }
    }
}
