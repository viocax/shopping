//
//  OrderCheckingViewController.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/22.
//

import UIKit
import RxCocoa
import RxSwift

class OrderCheckingViewController: UIViewController {

    private let disposeBag: DisposeBag = .init()
    private let tableView: UITableView = .init()
    private let titleLabel: UILabel = .init()
    private let descriptionLabel: UILabel = .init()
    private let priceLabel: UILabel = .init()
    private let submitButton: UIButton = .init()
    private let footerView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .extraLight)
        return UIVisualEffectView(effect: effect)
    }()
    private let viewModel: OrderCheckingViewModel
    init(viewModel: OrderCheckingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindView()
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.contentInset = .init(top: 0, left: 0, bottom: footerView.frame.size.height, right: 0)
    }
}

// MARK: Private
private extension OrderCheckingViewController {
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).inset(16)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 50, weight: .semibold)
        titleLabel.textColor = .black
        titleLabel.text = "付款項目"
        view.addSubview(footerView)
        footerView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
        footerView.contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        descriptionLabel.textColor = .black.withAlphaComponent(0.6)
        descriptionLabel.font = .systemFont(ofSize: 18, weight: .regular)
        descriptionLabel.numberOfLines = 0

        footerView.contentView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(descriptionLabel)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            make.height.equalTo(22)
        }
        priceLabel.textColor = .black
        priceLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        priceLabel.textAlignment = .right

        footerView.contentView.addSubview(submitButton)
        submitButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(priceLabel)
            make.top.equalTo(priceLabel.snp.bottom).offset(8)
            make.height.equalTo(48)
            make.bottom.equalTo(view.snp.bottomMargin).inset(24)
        }
        submitButton.setTitle("結帳", for: .normal)
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.backgroundColor = .black
        submitButton.layer.cornerRadius = 15

        view.insertSubview(tableView, at: 0)
        tableView.backgroundColor = .white
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.trailing.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        tableView.registerClass(UITableViewCell.self)
            .registerClass(OrderCheckingCell.self)
            .rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
        tableView.separatorStyle = .none
    }
    func bindView() {
        typealias CellForRowAt = ((UITableView, Int, OrderCellDisplayModel) -> UITableViewCell)
        let cellforRowAt: CellForRowAt = { tableView, row, model in
            guard let cell = tableView.dequeueReusableCell(OrderCheckingCell.self, indexPath: .init(row: row, section: .zero)) else {
                return .init()
            }
            cell.config(model)
            return cell
        }
        let bindView = PublishRelay<Void>()
        defer { bindView.accept(()) }
        let clickCheckOut = submitButton.rx.tap.debug().asDriverOnErrorJustComplete()
        let input = OrderCheckingViewModel
            .Input(
                bindView: bindView.asDriverOnErrorJustComplete(),
                clickCheckOut: clickCheckOut.asDriver()
            )
        let output = viewModel.transform(input)
        output.list
            .drive(tableView.rx.items)(cellforRowAt)
            .disposed(by: disposeBag)
        output.configuration
            .drive()
            .disposed(by: disposeBag)
        output.isLoading
            .drive(view.rx.indicatorAnimator)
            .disposed(by: disposeBag)
        output.footer
            .drive(footer)
            .disposed(by: disposeBag)
    }
    var footer: Binder<OrderFooterViewModel> {
        return Binder(self) { vc, model in
            vc.descriptionLabel.text = model.content
            vc.priceLabel.text = model.priceString
        }
    }
}
