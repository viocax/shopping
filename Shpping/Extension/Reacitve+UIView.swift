//
//  Reacitve+UIView.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/23.
//

import Foundation
import RxSwift

extension Reactive where Base: UIView {
    var indicatorAnimator: Binder<Bool> {
        return Binder(self.base) { (targetView, isLoading) in
            isLoading ? targetView.jie.start() : targetView.jie.stop()
        }
    }
    var isShowEmptyView: Binder<Bool> {
        return Binder(self.base) { targeView, isShow in
            isShow ? targeView.jie.showEmptyView() : targeView.jie.hideEmptyView()
        }
    }
}


private extension Jie where T: UIView {
    func start() {
        let indicatorView: IndicatorView
        if let indicator = self.base.subviews.first(where: { $0 is IndicatorView }) as? IndicatorView {
           indicatorView = indicator
        } else {
            let indicator = IndicatorView()
            self.base.addSubview(indicator)
            indicator.translatesAutoresizingMaskIntoConstraints = false
            indicator.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            indicatorView = indicator
        }
        indicatorView.startAnimation()
    }
    func stop() {
        let indicator = self.base.subviews.first(where: { $0 is IndicatorView }) as? IndicatorView
        indicator?.stopAnimation()
        indicator?.removeFromSuperview()
    }
    func showEmptyView() {
        hideEmptyView()
        let view = EmptyView()
        self.base.addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    func hideEmptyView() {
        self.base.subviews.first(where: { $0 is EmptyView })?.removeFromSuperview()
    }
}
