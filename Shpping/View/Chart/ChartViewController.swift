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
    private let confirmButton: UIButton = .init()
    private let tableView: UITableView = .init()
    private let titleLabel: UILabel = .init()
    private let footerView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .extraLight)
        return UIVisualEffectView(effect: effect)
    }()
    private let viewModel: ChartViewModel

    init(viewModel: ChartViewModel) {
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
        typealias CellForRowAt = (UITableView, Int, ChartViewCellViewModel) -> UITableViewCell
        let cellForRowAt: CellForRowAt = { tableView, row, model in
            guard let cell = tableView.dequeueReusableCell(ChartTableViewCell.self, indexPath: .init(row: row, section: .zero)) else {
                return .init()
            }
            cell.config(viewModel: model)
            return cell
        }
        let bindView = PublishRelay<Void>()
        defer { bindView.accept(()) }
        let tapCell = tableView.rx
            .modelSelected(ChartViewCellViewModel.self)
            .asDriver()
        let input = ChartViewModel
            .Input(
                bindView: bindView.asDriverOnErrorJustComplete(),
                tapCell: tapCell,
                clickCheckOut: confirmButton.rx.tap.asDriver()
            )
        let output = viewModel.transform(input)
        output.list
            .drive(tableView.rx.items)(cellForRowAt)
            .disposed(by: disposeBag)
        output.isEnablePurchase
            .drive(buttonEnable)
            .disposed(by: disposeBag)
        output.configuration
            .drive()
            .disposed(by: disposeBag)
    }
    var buttonEnable: Binder<Bool> {
        return Binder(self.confirmButton) { button, isEnable in
            button.backgroundColor = isEnable ? .black : .black.withAlphaComponent(0.5)
            button.isEnabled = isEnable
        }
    }
}
