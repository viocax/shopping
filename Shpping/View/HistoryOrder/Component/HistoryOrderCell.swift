//
//  HistoryOrderCell.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/23.
//

import UIKit

class HistoryOrderCell: UITableViewCell {

    private let borderView: UIView = .init()
    private let titleLabel: UILabel = .init()
    private let priceLabel: UILabel = .init()
    private let createTimeLabel: UILabel = .init()
    private let descriptionLabel: UILabel = .init()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension HistoryOrderCell {
    func setupView() {
        selectionStyle = .none
        contentView.backgroundColor = .white
        contentView.addSubview(borderView)
        borderView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(8)
        }
        borderView.backgroundColor = .gray.withAlphaComponent(0.2)
        borderView.layer.cornerRadius = 10

        borderView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(8)
        }
        titleLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        titleLabel.textColor = .black

        borderView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .black.withAlphaComponent(0.6)
        descriptionLabel.font = .systemFont(ofSize: 18, weight: .regular)
        
        borderView.addSubview(createTimeLabel)
        createTimeLabel.setContentHuggingPriority(.required, for: .horizontal)
        createTimeLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        createTimeLabel.snp.makeConstraints { make in
            make.leading.equalTo(descriptionLabel.snp.leading)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            make.bottom.equalToSuperview().inset(8)
        }
        createTimeLabel.textColor = .black.withAlphaComponent(0.3)
        createTimeLabel.font = .systemFont(ofSize: 22)
        
        borderView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(createTimeLabel)
            make.trailing.equalTo(descriptionLabel.snp.trailing)
            make.leading.equalTo(createTimeLabel.snp.trailing).offset(8)
        }
        priceLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        priceLabel.textColor = .black
    }
}

// MARK: Public
extension HistoryOrderCell {
    func config() {
        titleLabel.text = "Title test"
        descriptionLabel.text = "While this version aims to stay true to the original spirit and naming conventions of Rx, this projects also aims to provide a true Swift-first API for Rx APIs.Cross platform documentation can be found on ReactiveX.io.Like other Rx implementation, RxSwift intention is to enable easy composition of asynchronous operations and streams of data in the form of Observable objects and a suite of methods to transform and compose these pieces of asynchronous work."
        createTimeLabel.text = "\(Date().timeIntervalSince1970)"
        priceLabel.text = "$999999999"
    }
}
