//
//  HistoryOrderViewController.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/23.
//

import UIKit
import RxSwift
import RxCocoa

class HistoryOrderViewController: UIViewController {

    private let viewModel: HistoryOrderViewModel
    private let disposeBag: DisposeBag = .init()
    private let titleLabel: UILabel = .init()
    private let closeButton: UIButton = .init()
    private let tableView: UITableView = .init()

    init(viewModel: HistoryOrderViewModel) {
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
    }
}

// MARK: Private
private extension HistoryOrderViewController {
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(closeButton)
        closeButton.setImage(.init(named: "cancel"), for: .normal)
        closeButton.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.top.equalTo(view.snp.topMargin).inset(32)
            make.trailing.equalToSuperview().inset(16)
        }
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalTo(closeButton.snp.centerY)
            make.trailing.equalTo(closeButton.snp.leading).offset(-8)
            make.height.equalTo(60)
        }
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 50, weight: .semibold)
        titleLabel.text = "歷史交易紀錄"

        tableView.backgroundColor = .white
        view.addSubview(tableView)
        tableView.registerClass(UITableViewCell.self)
            .registerClass(HistoryOrderCell.self)
            .rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.separatorStyle = .none
        tableView.backgroundView = EmptyView()
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            
        }
        
    }
    func bindView() {
        typealias CellForRowAt = ((UITableView, Int, ShopItemsViewModel) -> UITableViewCell)
        let cellRowAt: CellForRowAt = { tableView, row, model in
            guard let cell = tableView.dequeueReusableCell(HistoryOrderCell.self, indexPath: .init(row: row, section: .zero)) else {
                return .init()
            }
            cell.config(model)
            return cell
        }
        let bindView = PublishRelay<Void>()
        defer { bindView.accept(()) }
        let input = HistoryOrderViewModel
            .Input(
                bindView: bindView.asDriverOnErrorJustComplete(),
                clickClose: closeButton.rx.tap.asDriver()
            )

        let output = viewModel.transform(input)
        output.list
            .drive(tableView.rx.items)(cellRowAt)
            .disposed(by: disposeBag)
        output.isLoading
            .drive(view.rx.indicatorAnimator)
            .disposed(by: disposeBag)
        output.configuration
            .drive()
            .disposed(by: disposeBag)
    }
}
