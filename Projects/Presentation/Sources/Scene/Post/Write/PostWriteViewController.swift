import UIKit
import SnapKit
import Then
import SharingKit
import RxFlow

public class PostWriteViewController: UIViewController {

    private let contentView = UIView()
    private let scrollView = UIScrollView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.bounces = false
        $0.contentInsetAdjustmentBehavior = .never
    }
    private let headerLabel = UILabel().then {
        $0.text = "게시글 작성"
        $0.textColor = .main
        $0.font = .headerH1SemiBold
    }
    private let titleTextField = SharingTextField().then {
        $0.placeholder = "20자까지 입력해주세요."
    }
    private let addressLabel = UILabel().then {
        $0.text = "활동 주소"
        $0.textColor = .black900
        $0.font = .bodyB2Medium
    }
    private let addressSearchButton = UIButton(type: .system).then {
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.setTitle("주소 검색하기", for: .normal)
        $0.setTitleColor(UIColor.black800, for: .normal)
        $0.titleLabel?.font = .bodyB2Medium
    }

    private let recruitmentTextField = SharingTextField(title: "모집 인원").then {
        $0.placeholder = "ex) 특정 지역, 연령대 등"
    }

    private let tagSettingTextField = SharingTextField(title: "태그 설정").then {
        $0.placeholder = "3개까지 입력 가능해요."
    }
    private let tagsScrollView = TagScrollView().then {
        $0.tags = ["안녕"]
    }

    private let serviceTimeTextField = SharingTextField(title: "봉사 시간").then {
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
    }

    let completeButton = FillButton(type: .system).then {
        $0.setTitle("작성 완료", for: .normal)
    }

    public override func viewDidLoad() {
        view.backgroundColor = .white
        addView()
        setLayout()
    }

    private func bind() {
    }

    private func addView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [
            headerLabel,
            titleTextField,
            addressLabel,
            addressSearchButton,
            recruitmentTextField,
            tagSettingTextField,
            tagsScrollView,
            serviceTimeTextField,
            detailsLabel,
            detailsTextView,
            completeButton
        ].forEach { contentView.addSubview($0) }
    }
    private func setLayout() {
        headerLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(75)
            $0.leading.equalToSuperview().inset(25)
            $0.height.equalTo(30)
        }
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(50)
        }
        addressLabel.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(15)
            $0.left.equalToSuperview().inset(25)
            $0.height.equalTo(20)
        }
        addressSearchButton.snp.makeConstraints {
            $0.top.equalTo(addressLabel.snp.bottom)
            $0.left.right.equalToSuperview().inset(25)
            $0.height.equalTo(40)
        }
        recruitmentTextField.snp.makeConstraints {
            $0.top.equalTo(addressSearchButton.snp.bottom).offset(35)
            $0.left.right.equalToSuperview().inset(25)
            $0.height.equalTo(50)
        }
        tagSettingTextField.snp.makeConstraints {
            $0.top.equalTo(recruitmentTextField.snp.bottom).offset(35)
            $0.left.right.equalToSuperview().inset(25)
            $0.height.equalTo(50)
        }
        tagsScrollView.snp.makeConstraints {
            $0.top.equalTo(tagSettingTextField.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(25)
            $0.height.equalTo(26)
        }
        serviceTimeTextField.snp.makeConstraints {
            $0.top.equalTo(tagsScrollView.snp.bottom).offset(35)
            $0.left.right.equalToSuperview().inset(25)
            $0.height.equalTo(50)
        }

        detailsLabel.snp.makeConstraints {
            $0.top.equalTo(serviceTimeTextField.snp.bottom).offset(15)
            $0.leading.equalTo(headerLabel.snp.leading)
            $0.height.equalTo(20)
        }
        detailsTextView.snp.makeConstraints {
            $0.top.equalTo(detailsLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(248)
        }
        completeButton.snp.makeConstraints {
            $0.top.equalTo(detailsTextView.snp.bottom).offset(15)
            $0.left.right.equalToSuperview().inset(25)
            $0.height.equalTo(40)
        }
        scrollView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
            $0.bottom.greaterThanOrEqualToSuperview()
        }

        contentView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
            $0.bottom.greaterThanOrEqualToSuperview()
            $0.bottom.equalTo(completeButton.snp.bottom).offset(64)
        }
    }
}
