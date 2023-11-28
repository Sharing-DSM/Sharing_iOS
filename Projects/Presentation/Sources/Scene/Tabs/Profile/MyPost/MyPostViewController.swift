import UIKit
import SnapKit
import Then
import SharingKit
import Core
import RxSwift
import RxCocoa

public class MyPostViewController: BaseVC<MyPostViewModel> {

    private let viewWillAppear = PublishRelay<Void>()
    private let showDetailRelay = PublishRelay<String>()

    private let headerLabel = UILabel().then {
        $0.text = "내 게시글"
        $0.textColor = .main
        $0.font = .headerH1SemiBold
    }
    private let myPostTableView = UITableView().then {
        $0.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        $0.separatorStyle = .none
    }
    public override func viewWillAppear(_ animated: Bool) {
        viewWillAppear.accept(())
    }
    public override func bind() {
        viewWillAppear.accept(())
        let input = MyPostViewModel.Input(
            viewWillAppear: viewWillAppear.asObservable(),
            showDetail: showDetailRelay.asObservable()
        )
        let output = viewModel.transform(input: input)
        output.myPost.asObservable()
            .bind(to: myPostTableView.rx.items(
                cellIdentifier: PostTableViewCell.identifier,
                cellType: PostTableViewCell.self)) { row, item, cell in
                    cell.setup(
                        cellID: item.id,
                        title: item.title,
                        address: item.addressName,
                        tag: item.type
                    )
                }.disposed(by: disposeBag)

        myPostTableView.rx.itemSelected
            .map { index -> String in
                guard let cell = self.myPostTableView.cellForRow(at: index) as? PostTableViewCell else { return "" }
                return cell.cellId ?? ""
            }
            .bind(to: showDetailRelay)
            .disposed(by: disposeBag)
        
    }
    public override func addView() {
        [
            headerLabel,
            myPostTableView
        ].forEach {view.addSubview($0)}
    }
    public override func setLayout(){
        headerLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(90)
            $0.left.equalToSuperview().inset(25)
            $0.height.equalTo(30)
        }
        myPostTableView.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom).offset(16)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
