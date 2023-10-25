import UIKit
import SnapKit
import Then
import SharingKit
import RxFlow

public class WriteViewController: UIViewController {
    public override func viewDidLoad() {
        view.backgroundColor = .white
        addView()
        setLayout()
    }
    private let scrollView = UIScrollView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.bounces = false
        $0.contentInsetAdjustmentBehavior = .never
    }
    private let contentView = UIView()
    private let headerLabel = UILabel().then {
        $0.text = "게시글 작성"
        $0.textColor = .main
        $0.font = .headerH1SemiBold
    }
    private let titleLabel = UILabel().then {
        $0.text = "제목"
        $0.textColor = .black900
        $0.font = .bodyB2Medium
    }
    private let titleTextField = SharingTextField().then {
        $0.placeholder = "20자까지 입력해주세요."
    }
    private let aderessLabel = UILabel().then {
        $0.text = "활동 주소"
        $0.textColor = .black900
        $0.font = .bodyB2Medium
    }
    private let aderessSearchButton = UIButton(type: .system).then {
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.setTitle("주소 검색하기", for: .normal)
        $0.setTitleColor(UIColor.black800, for: .normal)
        $0.titleLabel?.font = .bodyB2Medium
    }
    private let recruitmentLabel = UILabel().then {
        $0.text = "모집 인원"
        $0.textColor = .black900
        $0.font = .bodyB2Medium
    }
    private let recruitmentTextField = SharingTextField().then {
        $0.placeholder = "ex) 특정 지역, 연령대 등"
        $0.addLeftView()
    }
    private let tagSettingLabel = UILabel().then {
        $0.text = "태그 설정"
        $0.textColor = .black900
        $0.font = .bodyB2Medium
    }
    private let tagSettingTextField = SharingTextField().then {
        $0.placeholder = "3개까지 입력 가능해요."
    }
    private let serviceTimeLabel = UILabel().then {
        $0.text = "봉사 시간"
        $0.textColor = .black900
        $0.font = .bodyB2Medium
    }
    private let serviceTimeTextField = SharingTextField().then {
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

    private func bind() {
    }

    private func addView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [
            headerLabel,
            titleLabel,
            titleTextField,
            aderessLabel,
            aderessSearchButton,
            recruitmentLabel,
            recruitmentTextField,
            tagSettingLabel,
            tagSettingTextField,
            serviceTimeLabel,
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
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom).offset(15)
            $0.leading.equalTo(headerLabel.snp.leading)
            $0.height.equalTo(20)
        }
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(50)
        }
        aderessLabel.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(15)
            $0.leading.equalTo(headerLabel.snp.leading)
            $0.height.equalTo(20)
        }
        aderessSearchButton.snp.makeConstraints {
            $0.top.equalTo(aderessLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(40)
        }
        recruitmentLabel.snp.makeConstraints {
            $0.top.equalTo(aderessSearchButton.snp.bottom).offset(15)
            $0.leading.equalTo(headerLabel.snp.leading)
            $0.height.equalTo(20)
        }
        recruitmentTextField.snp.makeConstraints {
            $0.top.equalTo(recruitmentLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(50)
        }
        tagSettingLabel.snp.makeConstraints {
            $0.top.equalTo(recruitmentTextField.snp.bottom).offset(15)
            $0.leading.equalTo(headerLabel.snp.leading)
            $0.height.equalTo(20)
        }
        tagSettingTextField.snp.makeConstraints {
            $0.top.equalTo(tagSettingLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(50)
        }
        serviceTimeLabel.snp.makeConstraints {
            $0.top.equalTo(tagSettingTextField.snp.bottom).offset(15)
            $0.leading.equalTo(headerLabel.snp.leading)
            $0.height.equalTo(20)
        }
        serviceTimeTextField.snp.makeConstraints {
            $0.top.equalTo(serviceTimeLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(25)
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
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.bottom.equalToSuperview().inset(300)
            $0.height.equalTo(40)
        }
        scrollView.snp.makeConstraints {
            $0.top.trailing.leading.bottom.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalToSuperview()
        }
    }
}
