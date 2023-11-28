import UIKit
import SharingKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import Core

public class SearchViewController: BaseVC<SearchViewModel> {

    private let searchPost = PublishRelay<String>()
    private let showDetail = PublishRelay<String>()

    private let searchView = UISearchController().then {
        $0.searchBar.searchTextField.placeholder = "게시글 검색"
        $0.searchBar.searchTextField.font = .bodyB2Medium
        $0.automaticallyShowsCancelButton = false
        $0.hidesNavigationBarDuringPresentation = false
    }

    private let headerTitleLabel = UILabel().then {
        $0.text = "게시글 검색"
        $0.textColor = .black900
        $0.font = .bodyB1Medium
    }

    private let searchTableView = UITableView().then {
        $0.backgroundColor = .white
        $0.separatorStyle = .none
        $0.keyboardDismissMode = .onDrag
        $0.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
    }

    public override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }

    public override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }

    public override func attribute() {
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchView
        self.navigationItem.titleView = headerTitleLabel
    }

    public override func bind() {
        let input = SearchViewModel.Input(
            searchPost: searchPost.asObservable(),
            showDetail: showDetail.asObservable()
        )
        let output = viewModel.transform(input: input)

        output.searchPostData.asObservable()
            .bind(to: searchTableView.rx.items(
                cellIdentifier: PostTableViewCell.identifier,
                cellType: PostTableViewCell.self
            )) { row, data, cell in
                cell.setup(
                    cellID: data.id,
                    title: data.title,
                    address: data.addressName,
                    tag: data.type
                )
            }
            .disposed(by: disposeBag)

        searchTableView.rx.itemSelected
            .map { index -> String in
                guard let cell = self.searchTableView.cellForRow(at: index) as? PostTableViewCell
                else { return "" }
                return cell.cellId ?? ""
            }
            .bind(to: showDetail)
            .disposed(by: disposeBag)

        searchView.searchBar.searchTextField.rx.text
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .compactMap { $0 }
            .bind(to: searchPost)
            .disposed(by: disposeBag)
    }

    public override func addView() {
        view.addSubview(searchTableView)
    }

    public override func setLayout() {
        searchTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
