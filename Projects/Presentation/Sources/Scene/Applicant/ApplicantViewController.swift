import UIKit
import SharingKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import Domain
import Core

public class ApplicantViewController: BaseVC<ApplicantViewModel> {

    public var postID: String = ""

    private let fetchApplicantList = PublishRelay<String>()

    private let headerLabel = UILabel().then {
        $0.text = "신청자 목록"
        $0.textColor = .main
        $0.font = .headerH1SemiBold
    }

    private let collctionViewLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
        $0.sectionInset = .init(top: 8, left: 5, bottom: 8, right: 5)
        $0.minimumLineSpacing = 16
        $0.minimumInteritemSpacing = 5
        $0.itemSize = .init(width: 82, height: 133)
    }

    private lazy var applicantCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collctionViewLayout).then {
        $0.contentInset = .init(top: 5, left: 25, bottom: 10, right: 25)
        $0.showsVerticalScrollIndicator = false
        $0.register(ApplicantListCollectionViewCell.self, forCellWithReuseIdentifier: ApplicantListCollectionViewCell.identifier)
    }

    public override func attribute() {
        fetchApplicantList.accept(postID)
    }

    public override func bind() {
        let input = ApplicantViewModel.Input(
            fetchApplicantList: fetchApplicantList.asObservable()
        )
        let output = viewModel.transform(input: input)

        output.applicantListData.asObservable()
            .bind(to: applicantCollectionView.rx.items(
                cellIdentifier: ApplicantListCollectionViewCell.identifier,
                cellType: ApplicantListCollectionViewCell.self
            )) { row, element, cell in
                cell.setup(
                    profileImageLink: element.userProfile,
                    name: element.userName,
                    identifier: element.userID,
                    applicantAt: element.appliedAt
                )
            }
            .disposed(by: disposeBag)
    }

    public override func addView() {
        [
            headerLabel,
            applicantCollectionView
        ].forEach { view.addSubview($0) }
    }

    public override func setLayout() {
        headerLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.left.equalToSuperview().inset(25)
        }
        applicantCollectionView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(headerLabel.snp.bottom).offset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }
}

//extension ApplicantViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 30
//    }
//    
//    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ApplicantListCollectionViewCell.identifier, for: indexPath) as? ApplicantListCollectionViewCell else { return UICollectionViewCell() }
//
//        cell.setup()
//        return cell
//    }
//}
