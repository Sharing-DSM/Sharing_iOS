import UIKit
import SnapKit
import Then
import SharingKit
import RxFlow
import RxSwift
import RxCocoa
import Core

public class PostEditViewController: BaseVC<PostEditViewModel> {

    public var postId: String = ""

    private let fetchPostDetailRelay = PublishRelay<String>()
    private let patchPostRelay = BehaviorRelay<String>(value: "")

    private let contentView = UIView()
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.contentInsetAdjustmentBehavior = .never
    }
    private let headerLabel = UILabel().then {
        $0.text = "게시글 수정"
        $0.textColor = .main
        $0.font = .headerH1SemiBold
    }
    private let titleTextField = SharingTextField().then {
        $0.placeholder = "20자까지 입력해주세요."
    }
    private let addressMarkLabel = UILabel().then {
        $0.text = "활동 주소"
        $0.textColor = .black900
        $0.font = .bodyB2Medium
    }
    private let addressStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 14
    }
    private let selectAddressLabel = UILabel().then {
        $0.textColor = .black900
        $0.font = .bodyB2Medium
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    private let selectAddressBackground = UIView().then {
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black800?.cgColor
        $0.layer.cornerRadius = 10
    }
    private let addressSearchButton = UIButton(type: .system).then {
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.setTitle("주소 수정하기", for: .normal)
        $0.setTitleColor(UIColor.black800, for: .normal)
        $0.titleLabel?.font = .bodyB2Medium
    }

    private let recruitmentTextField = SharingTextField(title: "모집 인원", keyboardType: .asciiCapableNumberPad).then {
        $0.placeholder = "ex) 특정 지역, 연령대 등"
    }

    private let tagMarkLabel = UILabel().then {
        $0.text = "태그 설정"
        $0.textColor = .black900
        $0.font = .bodyB2Medium
    }
    private let tagSelectView = TagsSelectView()

    private let emergencyMarkLabel = UILabel().then {
        $0.text = "긴급 여부"
        $0.textColor = .black900
        $0.font = .bodyB2Medium
    }
    private let emergencyToggleButton = ToggleButton(type: .system)

    private let volunteerTimeTextField = SharingTextField(title: "봉사 시간", keyboardType: .asciiCapableNumberPad).then {
        $0.placeholder = "최대 100자리까지 숫자만 입력해주세요."
    }
    private let detailsLabel = UILabel().then {
        $0.text = "상세 내용"
        $0.textColor = .black900
        $0.font = .bodyB2Medium
    }
    private let detailsTextView = UITextView().then {
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.layer.borderColor = UIColor.black400?.cgColor
        $0.textContainerInset = .init(top: 15, left: 15, bottom: 15, right: 15)
    }
    private let completeEditButton = FillButton(type: .system).then {
        $0.setTitle("수정하기", for: .normal)
    }
    private let addressHelper: AddressHelperViewController

    public init(viewModel: PostEditViewModel, addressHelper: AddressHelperViewController) {
        self.addressHelper = addressHelper
        self.addressHelper.modalPresentationStyle = .overFullScreen
        self.addressHelper.modalTransitionStyle = .crossDissolve
        super.init(viewModel: viewModel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func attribute() {
        view.backgroundColor = .white
        settingDissmissGesture(target: [view])
        fetchPostDetailRelay.accept(postId)
    }

    public override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }

    public override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }

    public override func bind() {
        let input = PostEditViewModel.Input(
            titleText: titleTextField.rx.text.orEmpty.asObservable(),
            addressData: addressHelper.selectAddress.asObservable(),
            recruitmentText: recruitmentTextField.rx.text.orEmpty.asObservable(),
            tagData: tagSelectView.selectTagType.asObservable(),
            volunteerTimeText: volunteerTimeTextField.rx.text.orEmpty.asObservable(),
            detailContentText: detailsTextView.rx.text.orEmpty.asObservable(),
            isEmergency: emergencyToggleButton.isActivate.asObservable(),
            fetchPostDetail: fetchPostDetailRelay.asObservable(),
            patchPost: patchPostRelay.asObservable()
        )
        let output = viewModel.transform(input: input)

        output.isCompleteButtonEnable.asObservable()
            .subscribe(
                with: self,
                onNext: { owner, status in
                    owner.completeEditButton.isEnabled = status
                    owner.completeEditButton.backgroundColor = status ? .main : .black400
                }
            )
            .disposed(by: disposeBag)

        output.detailData.asObservable()
            .subscribe(
                with: self,
                onNext: { owner, data in
                    owner.titleTextField.text = data.title
                    owner.addressHelper.selectAddress.accept(
                        .init(
                            x: data.x,
                            y: data.y,
                            addressName: data.addressName,
                            roadAddressName: data.roadAddressName,
                            buildingName: ""
                        )
                    )
                    owner.recruitmentTextField.text = "\(data.recruitment)"
                    owner.tagSelectView.selectTagType.accept(data.type)
                    owner.volunteerTimeTextField.text = "\(data.volunteerTime)"
                    owner.detailsTextView.text = data.content
                    owner.emergencyToggleButton.isActivate.accept(data.isEmergency)
                }
            )
            .disposed(by: disposeBag)

        completeEditButton.rx.tap
            .subscribe(
                with: self,
                onNext: { owner, _ in
                    owner.patchPostRelay.accept(owner.postId)
                }
            )
            .disposed(by: disposeBag)

        addressSearchButton.rx.tap
            .subscribe(
                with: self,
                onNext: { owner, _ in
                    owner.present(owner.addressHelper, animated: true)
                }
            )
            .disposed(by: disposeBag)

        addressHelper.selectAddress
            .compactMap { $0 }
            .subscribe(
                with: self,
                onNext: { owner, data in
                    owner.selectAddressLabel.text = data.buildingName.isEmpty ?
                    data.roadAddressName : "\(data.roadAddressName)(\(data.buildingName))"
                }
            )
            .disposed(by: disposeBag)
    }

    public override func addView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        selectAddressBackground.addSubview(selectAddressLabel)
        [
            selectAddressBackground,
            addressSearchButton
        ].forEach { addressStackView.addArrangedSubview($0) }
        [
            headerLabel,
            titleTextField,
            addressMarkLabel,
            addressStackView,
            recruitmentTextField,
            tagMarkLabel,
            volunteerTimeTextField,
            detailsLabel,
            detailsTextView,
            tagSelectView,
            emergencyMarkLabel,
            emergencyToggleButton,
            completeEditButton
        ].forEach { contentView.addSubview($0) }
    }
    public override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.bottom.greaterThanOrEqualToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
            $0.bottom.greaterThanOrEqualToSuperview()
            $0.bottom.equalTo(completeEditButton.snp.bottom).offset(64)
        }
        headerLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(25)
            $0.height.equalTo(30)
        }

        // 제목
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(50)
        }

        // 주소
        addressMarkLabel.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(15)
            $0.leading.equalToSuperview().inset(25)
            $0.height.equalTo(20)
        }
        selectAddressLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.leading.trailing.equalToSuperview().inset(15)
        }
        addressStackView.snp.makeConstraints {
            $0.top.equalTo(addressMarkLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(25)
        }
        selectAddressBackground.snp.makeConstraints {
            $0.top.equalTo(addressStackView)
            $0.width.equalToSuperview()
            $0.bottom.equalTo(selectAddressLabel.snp.bottom).offset(24)
        }
        addressSearchButton.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(40)
        }

        // 모집인원
        recruitmentTextField.snp.makeConstraints {
            $0.top.equalTo(addressStackView.snp.bottom).offset(35)
            $0.left.right.equalToSuperview().inset(25)
            $0.height.equalTo(50)
        }

        // 테그
        tagMarkLabel.snp.makeConstraints {
            $0.top.equalTo(recruitmentTextField.snp.bottom).offset(24)
            $0.leading.equalToSuperview().inset(25)
            $0.height.equalTo(20)
        }
        tagSelectView.snp.makeConstraints {
            $0.top.equalTo(tagMarkLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(26)
        }

        // 봉사시간
        volunteerTimeTextField.snp.makeConstraints {
            $0.top.equalTo(tagSelectView.snp.bottom).offset(35)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(50)
        }

        // 상세 내용
        detailsLabel.snp.makeConstraints {
            $0.top.equalTo(volunteerTimeTextField.snp.bottom).offset(15)
            $0.leading.equalTo(headerLabel.snp.leading)
            $0.height.equalTo(20)
        }
        detailsTextView.snp.makeConstraints {
            $0.top.equalTo(detailsLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(248)
        }

        // 긴급 여부
        emergencyMarkLabel.snp.makeConstraints {
            $0.top.equalTo(detailsTextView.snp.bottom).offset(27)
            $0.leading.equalToSuperview().inset(25)
            $0.height.equalTo(20)
        }
        emergencyToggleButton.snp.makeConstraints {
            $0.centerY.equalTo(emergencyMarkLabel)
            $0.leading.equalTo(emergencyMarkLabel.snp.trailing).offset(8)
            $0.width.height.equalTo(25)
        }

        // 완료 버튼
        completeEditButton.snp.makeConstraints {
            $0.top.equalTo(emergencyMarkLabel.snp.bottom).offset(26)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(40)
        }
    }
}
