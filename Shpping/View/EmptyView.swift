//
//  EmptyView.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/23.
//

import UIKit

class EmptyView: UIView {
    private let imageView: UIImageView = .init(image: .init(named: "empty"))
    private let label: UILabel = .init()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        backgroundColor = .white
        addSubview(imageView)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.size.equalTo(100)
        }
        addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(imageView.snp.top).offset(-20)
        }
        label.text = "空空如也"
        label.textColor = .black
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .center
    }
}
