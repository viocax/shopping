//
//  IndicatorView.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/23.
//

import Foundation
import UIKit

class IndicatorView: UIView {
    private let blurView: UIView = .init()
    private let indicatorView: UIActivityIndicatorView = .init(style: .medium)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    private func setupView() {
        isUserInteractionEnabled = true
        addSubview(blurView)
        blurView.isUserInteractionEnabled = true
        blurView.layer.cornerRadius = 10
        blurView.clipsToBounds = true
        blurView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        blurView.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.width.height.equalTo(67)
        }
        addSubview(indicatorView)
        indicatorView.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.width.height.equalTo(35)
        }
    }
    public func startAnimation() {
        indicatorView.startAnimating()
    }
    public func stopAnimation() {
        indicatorView.stopAnimating()
    }
}
