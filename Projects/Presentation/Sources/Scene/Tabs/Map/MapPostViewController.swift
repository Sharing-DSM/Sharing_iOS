import UIKit
import SnapKit
import SharingKit
import Then
import RxSwift
import RxCocoa
import RxSwift
import Core

public class MapPostViewController: BaseVC<MapViewModel> {

    private let viewDidLoadSignal = PublishRelay<Void>()
    private let selectItemWithID = PublishRelay<String>()

    let postTableView = UITableView().then {
        $0.rowHeight = UITableView.automaticDimension
        $0.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 10))
        $0.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 40))
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .black50
        $0.separatorStyle = .none
        $0.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.id)
    }

    public override func attribute() {
        view.backgroundColor = .black50
        viewDidLoadSignal.accept(())
    }

    public override func addView() {
        view.addSubview(postTableView)
    }

    public override func setLayout() {
        postTableView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(35)
            $0.left.right.equalToSuperview()
            $0.bottom.greaterThanOrEqualToSuperview()
        }
    }

    public override func bind() {
        let input = MapViewModel.Input(
            viewDidLoad: viewDidLoadSignal.asObservable(),
            writePostButtonDidClick: nil,
            selectItem: selectItemWithID.asSignal()
        )
        let output = viewModel.transform(input: input)

        postTableView.rx.itemSelected
            .map { index -> String in
                guard let cell = self.postTableView.cellForRow(at: index) as? PostTableViewCell else {
                    return ""
                }
                return cell.cellId ?? ""
            }
            .bind(to: selectItemWithID)
            .disposed(by: disposeBag)

        output.totalPostData.asObservable()
            .bind(to: postTableView.rx.items(cellIdentifier: PostTableViewCell.id, cellType: PostTableViewCell.self)) { (index, element, cell) in
                cell.settingCell(
                    title: element.title,
                    address: element.addressName,
                    tags: [element.type],
                    cellId: element.id
                )
            }
            .disposed(by: disposeBag)
    }
}
