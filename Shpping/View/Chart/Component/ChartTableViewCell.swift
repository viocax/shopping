//
//  ChartTableViewCell.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/22.
//

import UIKit

class ChartTableViewCell: UITableViewCell {

    private let pictureImageView: UIImageView = .init()
    private let checkBarView: UIImageView = .init()
    private let titleLabel: UILabel = .init()
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
private extension ChartTableViewCell {
    func setupView() {
        backgroundColor = .white
        contentView.backgroundColor = .white
        selectionStyle = .none
        contentView.addSubview(checkBarView)
        checkBarView.image = .init(named: "uncheck")
        checkBarView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(24)
            make.size.equalTo(24)
        }
        contentView.addSubview(pictureImageView)
        pictureImageView.snp.makeConstraints { make in
            make.size.equalTo(80)
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.equalTo(checkBarView.snp.trailing).offset(16)
        }
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(pictureImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(4)
        }
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)

        contentView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleLabel)
            make.top.greaterThanOrEqualTo(titleLabel.snp.bottom).inset(8)
            make.bottom.equalTo(pictureImageView.snp.bottom)
        }
        priceLabel.textAlignment = .right
        priceLabel.textColor = .black
        priceLabel.font = .systemFont(ofSize: 16)
    }
}

// MARK: Public
extension ChartTableViewCell {
    // FIXME: interface
    func config() {
        titleLabel.text = "jsdgklsndgls"
        priceLabel.text = "$lsdakngf"
        pictureImageView.image = .init(named: "test")
        checkBarView.image = Bool.random() ? .init(named: "check") : .init(named: "uncheck")
    }
}
