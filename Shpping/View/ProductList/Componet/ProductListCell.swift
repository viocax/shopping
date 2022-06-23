//
//  ProductListCell.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/22.
//

import UIKit
import Kingfisher

class ProductListCell: UITableViewCell {

    private let titleLabel: UILabel = .init()
    private let descriptionLabel: UILabel = .init()
    private let priceLabel: UILabel = .init()
    private let createTimeLabel: UILabel = .init()
    private let pictureImageView: UIImageView = .init()
    private let borderView: UIView = .init()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        pictureImageView.kf.cancelDownloadTask()
    }
}

// MARK: private
private extension ProductListCell {
    func setupView() {
        contentView.backgroundColor = .white
        selectionStyle = .none
        contentView.addSubview(borderView)
        borderView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        borderView.backgroundColor = .gray.withAlphaComponent(0.2)
        borderView.layer.cornerRadius = 10
        borderView.addSubview(pictureImageView)
        pictureImageView.contentMode = .scaleAspectFill
        pictureImageView.clipsToBounds = true
        pictureImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(16)
            make.size.equalTo(80)
        }
        borderView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(pictureImageView.snp.top)
            make.trailing.equalToSuperview().inset(16)
            make.leading.equalTo(pictureImageView.snp.trailing).offset(8)
            make.height.equalTo(30)
        }
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        borderView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(titleLabel)
        }
        descriptionLabel.textColor = .black
        descriptionLabel.numberOfLines = 0

        borderView.addSubview(createTimeLabel)
        createTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            make.leading.equalTo(titleLabel)
            make.height.equalTo(25)
            make.bottom.equalToSuperview().inset(16)
        }
        createTimeLabel.setContentHuggingPriority(.required, for: .horizontal)
        createTimeLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        createTimeLabel.textColor = .black

        borderView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.trailing.equalTo(titleLabel.snp.trailing)
            make.bottom.equalTo(createTimeLabel.snp.bottom)
            make.leading.equalTo(createTimeLabel.snp.trailing)
            make.height.equalTo(createTimeLabel)
        }
        priceLabel.textAlignment = .right
        priceLabel.textColor = .black
    }
}

// MARK: Public
extension ProductListCell {
    func configCell(_ viewModel: ProductListCellViewModel & DateConvertable) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        createTimeLabel.text = viewModel.toString(by: viewModel.createTime)
        priceLabel.text = viewModel.price
        pictureImageView.kf.setImage(with: viewModel.image, placeholder: UIImage(named: "warning"), options: nil, completionHandler: nil)
    }
}
