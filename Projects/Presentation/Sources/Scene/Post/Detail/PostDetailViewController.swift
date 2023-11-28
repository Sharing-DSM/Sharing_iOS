import UIKit
import SnapKit
import Then
import SharingKit
import RxSwift
import RxCocoa
import Core
import Kingfisher

public class PostDetailViewController: BaseVC<PostDetailViewModel> {

    public var id: String = ""
    public var userID: String = ""

    private let createChatRoom = PublishRelay<String>()
    private let fetchDetailRelay = PublishRelay<String>()
    private let deletePostRelay = PublishRelay<String>()
    private let editPostRelay = PublishRelay<String>()
    private let applicationRelay = PublishRelay<String>()
    private let applicantListRelay = PublishRelay<String>()

    private let backgroundView = UIView().then {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .black50
        $0.setShadow()
    }
    private let locationImageView = UIImageView().then {
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
        $0.backgroundColor = .black100
        $0.image = .profileImage
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black400?.cgColor
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
    private let interactionButton = UIButton(type: .system).then {
        $0.setImage(.interactionDot.withTintColor(.black700!, renderingMode: .alwaysOriginal), for: .normal)
        $0.showsMenuAsPrimaryAction = true
        $0.isHidden = true
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
        $0.textAlignment = .left
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
    private let alertController = UIAlertController(
        title: "게시글 삭제",
        message: "정말 게시글을 삭제하실건가요?",
        preferredStyle: .alert
    )

    private func settingAlert() {
        let deleteAlertAction = UIAlertAction(title: "삭제", style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            self.deletePostRelay.accept(self.id)
        }
        let cancelAlertAction = UIAlertAction(title: "취소", style: .cancel)
        [cancelAlertAction, deleteAlertAction].forEach { alertController.addAction($0) }
    }

    private func settingMenu() {
        let applicantListButton = UIAction(
            title: "신청목록",
            image: UIImage(systemName: "list.clipboard"),
            handler: { [weak self] _ in
                guard let self = self else { return }
                applicantListRelay.accept(id)
            }
        )
        let postEditButton = UIAction(
            title: "수정하기",
            image: UIImage(systemName: "pencil"),
            handler: { [weak self] _ in
                guard let self = self else { return }
                editPostRelay.accept(id)
            }
        )
        let postDeleteButton = UIAction(
            title: "삭제하기",
            image: UIImage(systemName: "trash"),
            attributes: .destructive,
            handler: { [weak self] _ in
                guard let self = self else { return }
                present(alertController, animated: true)
            }
        )
        let postDatailMenu = UIMenu(
            title: "",
            image: nil,
            identifier: nil,
            options: .destructive,
            children: [applicantListButton, postEditButton, postDeleteButton]
        )
        interactionButton.menu = postDatailMenu
    }

    public override func viewWillAppear(_ animated: Bool) {
        fetchDetailRelay.accept(id)
    }

    public override func attribute() {
        view.backgroundColor = .white
        settingAlert()
        settingMenu()
    }

    public override func bind() {
        let input = PostDetailViewModel.Input(
            fetchDetailView: fetchDetailRelay.asObservable(),
            showApplicantList: applicantListRelay.asObservable(),
            deletePost: deletePostRelay.asObservable(),
            editPost: editPostRelay.asObservable(),
            chatButtonDidClick: createChatRoom.asObservable(),
            applicationButtonDidClick: applicationRelay.asObservable()
        )
        let output = viewModel.transform(input: input)

        chatButton.rx.tap
            .map { self.userID }
            .bind(to: createChatRoom)
            .disposed(by: disposeBag)

        applyButton.rx.tap
            .map { self.id }
            .bind(to: applicationRelay)
            .disposed(by: disposeBag)

        output.detailData.asObservable()
            .subscribe(
                with: self,
                onNext: { owner, data in
                    owner.titleLabel.text = data.title
                    owner.addressLabel.text = data.addressName
                    owner.volunteerTimeLabel.text = "봉사 시간 : \(data.volunteerTime)시간"
                    owner.recruitmentLabel.text = "모집 인원 : \(data.recruitment)명"
                    owner.detailsLabel.text = data.content
                    owner.interactionButton.isHidden = !data.isMine
                    owner.chatButton.isHidden = data.isMine
                    owner.applyButton.isHidden = data.isMine
                    owner.locationImageView.kf.setImage(with: URL(string: data.userProfile))
                    owner.userID = data.userID
                }
            )
            .disposed(by: disposeBag)
    }

    public override func addView() {
        view.addSubview(backgroundView)
        [
            locationImageView,
            titleLabel,
            addressLabel,
            interactionButton,
            volunteerTimeLabel,
            recruitmentLabel,
            detailsLabel
        ].forEach { backgroundView.addSubview($0) }
        [
            chatButton,
            applyButton
        ].forEach { view.addSubview($0) }
    }

    public override func setLayout() {
        backgroundView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.bottom.equalToSuperview().inset(207)
        }
        locationImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(21)
            $0.width.height.equalTo(40)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(locationImageView.snp.top)
            $0.leading.equalTo(locationImageView.snp.trailing).offset(10)
            $0.height.equalTo(20)
        }
        addressLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.height.equalTo(18)
        }
        interactionButton.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.top.trailing.equalToSuperview().inset(20)
        }
        volunteerTimeLabel.snp.makeConstraints {
            $0.top.equalTo(locationImageView.snp.bottom).offset(20)
            $0.trailing.leading.equalToSuperview().inset(21)
            $0.height.equalTo(20)
        }
        recruitmentLabel.snp.makeConstraints {
            $0.top.equalTo(volunteerTimeLabel.snp.bottom)
            $0.trailing.leading.equalToSuperview().inset(21)
            $0.height.equalTo(20)
        }
        detailsLabel.snp.makeConstraints {
            $0.top.equalTo(recruitmentLabel.snp.bottom).offset(10)
            $0.trailing.leading.equalToSuperview().inset(21)
        }
        applyButton.snp.makeConstraints {
            $0.top.equalTo(backgroundView.snp.bottom).offset(10)
            $0.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(40)
            $0.width.equalTo(92)
        }
        chatButton.snp.makeConstraints {
            $0.top.equalTo(applyButton.snp.top)
            $0.trailing.equalTo(applyButton.snp.leading).offset(-10)
            $0.width.equalTo(92)
            $0.height.equalTo(40)
        }
    }
}
