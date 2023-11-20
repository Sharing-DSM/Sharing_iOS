import UIKit
import SnapKit
import SharingKit
import Then
import RxSwift
import RxCocoa
import RxSwift
import Core

public class MapPostViewController: BaseVC<MapViewModel> {

    private var userID: String = ""

    private let selectItemWithID = PublishRelay<String>()
    private let createChatRoom = PublishRelay<String>()

    let postDetailView = UIView().then {
        $0.backgroundColor = .black50
        $0.isHidden = true
    }

    let postDetailBackgroundView = UIView().then {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .white
        $0.setShadow()
    }

    private let profileImageView = UIImageView().then {
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
        $0.backgroundColor = .black
        $0.image = UIImage(named: "example")
    }
    private let titleLabel = UILabel().then {
        $0.text = "-"
        $0.font = .bodyB2SemiBold
    }
    private let addressLabel = UILabel().then {
        $0.text = "-"
        $0.font = .bodyB3Medium
        $0.textColor = .black800
    }
    private let volunteerTimeLabel = UILabel().then {
        $0.text = "봉사 시간 :"
        $0.font = .bodyB2Bold
        $0.textColor = .black900
    }
    private let recruitmentLabel = UILabel().then {
        $0.text = "모집 인원 :"
        $0.font = .bodyB2Bold
        $0.textColor = .black900
    }
    private let detailsLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textAlignment = .natural
        $0.font = .bodyB2Medium
        $0.textColor = .black900
    }
    private let chatButton = FillButton(type: .system).then {
        $0.setTitle("채팅하기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .black200
        $0.setShadow()
    }
    private let applyButton = FillButton(type: .system).then {
        $0.setTitle("신청하기", for: .normal)
    }

    let postTableView = UITableView().then {
        $0.rowHeight = UITableView.automaticDimension
        $0.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 10))
        $0.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 40))
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .black50
        $0.separatorStyle = .none
        $0.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
    }

    public override func attribute() {
        view.backgroundColor = .black50
    }

    public override func bind() {
        let input = MapViewModel.Input(
            writePostButtonDidClick: nil,
            selectItem: selectItemWithID.asSignal(),
            fetchSurroundingPost: nil,
            dismissPostDetail: nil,
            createChatRoom: createChatRoom.asObservable()
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

        chatButton.rx.tap
            .map { self.userID }
            .bind(to: createChatRoom)
            .disposed(by: disposeBag)

        output.postDetailData.asObservable()
            .subscribe(
                with: self,
                onNext: { owner, data in
                    owner.titleLabel.text = data.title
                    owner.addressLabel.text = data.addressName
                    owner.volunteerTimeLabel.text = "봉사 시간 : \(data.volunteerTime)시간"
                    owner.recruitmentLabel.text = "모집 인원 : \(data.recruitment)명"
                    owner.detailsLabel.text = data.content
                    owner.userID = data.userID
                    owner.chatButton.isHidden = data.isMine
                    owner.applyButton.isHidden = data.isMine
                    owner.postDetailView.isHidden = false
                }
            )
            .disposed(by: disposeBag)

        output.surroundPostData.asObservable()
            .bind(to: postTableView.rx.items(
                cellIdentifier: PostTableViewCell.identifier,
                cellType: PostTableViewCell.self
            )) { (index, element, cell) in
                cell.postTitleLable.text = element.title
                cell.addressLable.text = element.addressName
                cell.tagView.setTag(element.type.toTagName)
                cell.cellBackgroundView.backgroundColor = .white
                cell.cellId = element.id
                
                cell.setup()
            }
            .disposed(by: disposeBag)

        output.dismissPostDetail.asObservable()
            .map { true }
            .bind(to: postDetailView.rx.isHidden)
            .disposed(by: disposeBag)
    }

    public override func addView() {
        [
            profileImageView,
            titleLabel,
            addressLabel,
            volunteerTimeLabel,
            recruitmentLabel,
            detailsLabel
        ].forEach({ postDetailBackgroundView.addSubview($0) })
        [
            postDetailBackgroundView,
            chatButton,
            applyButton
        ].forEach({ postDetailView.addSubview($0) })
        [
            postTableView,
            postDetailView
        ].forEach( { view.addSubview($0) })
    }

    public override func setLayout() {
        postDetailView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.bottom.greaterThanOrEqualToSuperview()
        }

        postDetailBackgroundView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(35)
            $0.left.right.equalToSuperview().inset(26)
            $0.bottom.greaterThanOrEqualTo(view.snp.centerY).offset(40)
            $0.bottom.greaterThanOrEqualTo(detailsLabel.snp.bottom).offset(32)
        }
        profileImageView.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.top.equalToSuperview().inset(12)
            $0.left.equalToSuperview().inset(20)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView)
            $0.left.equalTo(profileImageView.snp.right).offset(10)
            $0.right.equalToSuperview().inset(20)
            $0.height.equalTo(20)
        }
        addressLabel.snp.makeConstraints {
            $0.left.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.right.equalToSuperview().inset(20)
            $0.height.equalTo(18)
        }
        volunteerTimeLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20)
            $0.top.equalTo(profileImageView.snp.bottom).offset(10)
            $0.height.equalTo(20)
        }
        recruitmentLabel.snp.makeConstraints {
            $0.top.equalTo(volunteerTimeLabel.snp.bottom)
            $0.left.right.equalTo(volunteerTimeLabel)
            $0.height.equalTo(20)
        }
        detailsLabel.snp.makeConstraints {
            $0.top.equalTo(recruitmentLabel.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(20)
        }
        chatButton.snp.makeConstraints {
            $0.top.equalTo(postDetailBackgroundView.snp.bottom).offset(10)
            $0.left.equalTo(postDetailBackgroundView)
            $0.height.equalTo(40)
            $0.width.equalTo(92)
        }
        applyButton.snp.makeConstraints {
            $0.top.equalTo(chatButton)
            $0.left.equalTo(chatButton.snp.right).offset(10)
            $0.height.equalTo(40)
            $0.width.equalTo(92)
        }

        postTableView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(35)
            $0.left.right.equalToSuperview()
            $0.bottom.greaterThanOrEqualToSuperview()
        }
    }
}
