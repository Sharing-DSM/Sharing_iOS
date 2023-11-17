import Core
import UIKit
import Then
import SnapKit
import SharingKit
import RxSwift
import RxCocoa

public class ApplyHistoryViewController: BaseVC<ApplyHistroyViewModel> {

    private let viewWillAppear = PublishRelay<Void>()
    private let headerLabel = UILabel().then {
        $0.text = "내가 신청한 게시글"
        $0.textColor = .main
        $0.font = .headerH1SemiBold
    }
    private let applyTableView = UITableView().then {
        $0.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        $0.separatorStyle = .none
    }

    public override func viewWillAppear(_ animated: Bool) {
        viewWillAppear.accept(())
    }
    public override func bind() {
        let input = ApplyHistroyViewModel.Input(viewWillAppear: viewWillAppear.asObservable())
        let output = viewModel.transform(input: input)
        output.ApplyHistoryData.asObservable().bind(to: applyTableView.rx.items(
                cellIdentifier: PostTableViewCell.identifier,
                cellType: PostTableViewCell.self)) { [weak self] row, item, cell in
                    cell.cellId = item.id
                    cell.tagView.setTag(item.feedType.toTagName)
                    cell.postTitleLable.text = item.title
                    cell.addressLable.text = item.address
                }.disposed(by: disposeBag)
    }

    public override func addView() {
        [
            headerLabel,
            applyTableView
        ].forEach { view.addSubview($0)}
    }
    public override func setLayout() {
        headerLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(90)
            $0.left.equalToSuperview().inset(25)
            $0.height.equalTo(30)
        }
        applyTableView.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom).offset(16)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
