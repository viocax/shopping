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
    private let viewModel: ProductListViewModel
    private let pullRefreshControl: UIRefreshControl = .init()
    private let loadMorePublisher: PublishRelay<Bool> = .init()
    
    private let disposeBag: DisposeBag = .init()

    init(viewModel: ProductListViewModel) {
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
        tableView.refreshControl = pullRefreshControl
        setBarBlur()
        title = "商品"
    }
    func bindView() {
        // FIXME: interface
        typealias CellForRowAt = ((UITableView, Int, (ShopItemsViewModel & DateConvertable)) -> UITableViewCell)
        let cellForRow: CellForRowAt = { tableView, row, model in
            guard let cell = tableView.dequeueReusableCell(ProductListCell.self, indexPath: .init(row: row, section: .zero)) else {
                return .init()
            }
            cell.configCell(model)
            return cell
        }
        let clickCell = tableView.rx
            .modelSelected(ShopItemsViewModel.self)
            .asDriver()
        let loadingMore = loadMorePublisher
            .distinctUntilChanged()
            .filter { $0 }
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        let pullRefresh = pullRefreshControl.rx
            .controlEvent(.valueChanged)
            .asDriver()
        let input = ProductListViewModel
            .Input(
                viewWillAppear: rx.viewWillAppear.asDriver(),
                pullRefresh: pullRefresh,
                loadingMore: loadingMore,
                clickProduct: clickCell
            )
        let output = viewModel.transform(input)
        output.isLoading
            .drive(view.rx.indicatorAnimator)
            .disposed(by: disposeBag)
        output.confirguration
            .drive()
            .disposed(by: disposeBag)
        output.list
            .drive(tableView.rx.items)(cellForRow)
            .disposed(by: disposeBag)
        output.list.map { _ in }
            .drive(endRefreshingIfNeed)
            .disposed(by: disposeBag)
        output.isEmpty
            .drive(view.rx.isShowEmptyView)
            .disposed(by: disposeBag)
        output.error
            .drive()
            .disposed(by: disposeBag)
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    var endRefreshingIfNeed: Binder<Void> {
        return Binder(self.pullRefreshControl) { control, _ in
            control.isRefreshing ? control.endRefreshing() : ()
        }
    }
}

// MARK: UIScrollViewDelegate
extension ProductListViewController: UIScrollViewDelegate {
    private func detectScrollToBottomEdge(_ scrollView: UIScrollView) {
        let isScrollToBottom = scrollView.contentOffset.y + scrollView.frame.size.height >= scrollView.contentSize.height
        loadMorePublisher.accept(isScrollToBottom)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        detectScrollToBottomEdge(scrollView)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        detectScrollToBottomEdge(scrollView)
    }
}

extension UIViewController {
    func setBarBlur() {
        guard let navigationVC = navigationController else {
            return
        }
        let barAppearance = UINavigationBarAppearance()
        navigationVC.navigationBar.standardAppearance = barAppearance
        navigationVC.navigationBar.scrollEdgeAppearance = barAppearance
    }
}
