//
//  ProductListViewController.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/22.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class ProductListViewController: UIViewController {
    private let tableView: UITableView = .init()
    private let disposeBag: DisposeBag = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindView()

        // Do any additional setup after loading the view.
    }

}

// MARK: private
private extension ProductListViewController {
    func setupView() {
        view.backgroundColor = .white
        tableView.backgroundColor = .white
        view.addSubview(tableView)
        tableView.registerClass(UITableViewCell.self)
            .registerClass(ProductListCell.self)
            .snp.makeConstraints { make in
                make.top.trailing.leading.bottom.equalToSuperview()
            }
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.separatorStyle = .none
    }
    func bindView() {
        // FIXME: interface
        typealias CellForRowAt = ((UITableView, Int, (ProductListCellViewModel & DateConvertable)) -> UITableViewCell)
        let cellForRow: CellForRowAt = { tableView, row, model in
            guard let cell = tableView.dequeueReusableCell(ProductListCell.self, indexPath: .init(row: row, section: .zero)) else {
                return .init()
            }
            cell.configCell(model)
            return cell
        }
//        Driver.just((0...10).map(String.init))
//            .drive(tableView.rx.items)(cellForRow)
//            .disposed(by: disposeBag)
    }
}

