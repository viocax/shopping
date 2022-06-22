//
//  ChartViewController.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/22.
//

import UIKit
import RxSwift
import RxCocoa

class ChartViewController: UIViewController {

    private let disposeBag: DisposeBag = .init()
    private let emptyView: UIView = .init()
    private let confirmButton: UIButton = .init()
    private let tableView: UITableView = .init()
    private let titleLabel: UILabel = .init()
    private let footerView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .extraLight)
        return UIVisualEffectView(effect: effect)
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindView()
        // Do any additional setup after loading the view.
    }

}

// MARK: Private
private extension ChartViewController {
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

        view.addSubview(footerView)
        footerView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
        footerView.contentView.addSubview(confirmButton)
        confirmButton.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview().inset(20)
            make.height.equalTo(48)
            make.bottom.equalTo(view.snp.bottomMargin).inset(24)
        }
        confirmButton.setTitle("結算", for: .normal)
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.backgroundColor = .black
        confirmButton.layer.cornerRadius = 15
        
        view.addSubview(tableView)
        tableView.backgroundColor = .white
        tableView.estimatedRowHeight = 80
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.registerClass(UITableViewCell.self)
            .registerClass(ChartTableViewCell.self)
            .snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(24)
                make.leading.trailing.equalToSuperview()
                make.bottom.equalTo(footerView.snp.top)
            }

        titleLabel.text = "購物車"
    }
    func bindView() {
        typealias CellForRowAt = (UITableView, Int, String) -> UITableViewCell
        let cellForRowAt: CellForRowAt = { tableView, row, model in
            guard let cell = tableView.dequeueReusableCell(ChartTableViewCell.self, indexPath: .init(row: row, section: .zero)) else {
                return .init()
            }
            cell.config()
            return cell
        }
        Driver.just((0...10).map(String.init))
            .drive(tableView.rx.items)(cellForRowAt)
            .disposed(by: disposeBag)

    }
}
