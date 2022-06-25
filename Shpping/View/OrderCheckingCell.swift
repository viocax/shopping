//
//  OrderCheckingCell.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/22.
//

import UIKit

class OrderCheckingCell: UITableViewCell {

    private let titleLabel: UILabel = .init()
    private let descriptionLabel: UILabel = .init()
    private let priceLabel: UILabel = .init()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension OrderCheckingCell {
    func setupView() {
        backgroundColor = .white
        contentView.backgroundColor = .white
        selectionStyle = .none
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview().inset(16)
        }
        titleLabel.font = .systemFont(ofSize: 30, weight: .semibold)
        titleLabel.textColor = .black
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        descriptionLabel.setContentHuggingPriority(.required, for: .vertical)
        descriptionLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        descriptionLabel.numberOfLines = .zero
        descriptionLabel.font = .systemFont(ofSize: 20, weight: .thin)
        descriptionLabel.textColor = .black.withAlphaComponent(0.6)
        contentView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(descriptionLabel)
            make.bottom.equalToSuperview().inset(8)
        }
        priceLabel.font = .systemFont(ofSize: 24, weight: .regular)
        priceLabel.textColor = .black
        priceLabel.textAlignment = .right
    }
}

// MARK: Public
extension OrderCheckingCell {
    func config(_ model: OrderCellDisplayModel) {
        titleLabel.text = model.title
        descriptionLabel.text = model.title
        priceLabel.text = model.price
    }
}
