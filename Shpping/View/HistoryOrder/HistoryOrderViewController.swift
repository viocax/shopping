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

    private let disposeBag: DisposeBag = .init()
    private let titleLabel: UILabel = .init()
    private let tableView: UITableView = .init()

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
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(view.snp.topMargin).inset(16)
            make.height.equalTo(60)
        }
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 50, weight: .semibold)

        tableView.backgroundColor = .white
        view.addSubview(tableView)
        tableView.registerClass(UITableViewCell.self)
            .registerClass(HistoryOrderCell.self)
            .rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.separatorStyle = .none
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
    }
    func bindView() {
        typealias CellForRowAt = ((UITableView, Int, String) -> UITableViewCell)
        let cellRowAt: CellForRowAt = { tableView, row, model in
            guard let cell = tableView.dequeueReusableCell(HistoryOrderCell.self, indexPath: .init(row: row, section: .zero)) else {
                return .init()
            }
            cell.config()
            return cell
        }
        Driver.just((0...10).map(String.init))
            .drive(tableView.rx.items)(cellRowAt)
            .disposed(by: disposeBag)
        titleLabel.text = "歷史交易紀錄"
    }
}
