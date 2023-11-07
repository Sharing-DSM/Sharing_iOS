import UIKit
import SnapKit
import Then
import SharingKit

public class PostDetailViewController: UIViewController {

    public var id: String = ""

    public override func viewDidLoad() {
        view.backgroundColor = .white
        addView()
        setLayout()
    }

    private let backgroundView = UIView().then {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .black50
        $0.setShadow()
    }
    private let locationImageView = UIImageView().then {
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
        $0.backgroundColor = .black
        $0.image = UIImage(named: "example")
    }
    private let titleLabel = UILabel().then {
        $0.text = "어르신 휠체어 이동 도움 및 보조 활동"
        $0.font = .bodyB2SemiBold
    }
    private let addressLabel = UILabel().then {
        $0.text = "유성구 전민동"
        $0.font = .bodyB3Medium
        $0.textColor = .black800
    }
    private let targetLabel = UILabel().then {
        $0.text = "지원 대상 : 대전 거주자"
        $0.font = .bodyB2Medium
        $0.textColor = .black900
    }
    private let detailAddressLabel = UILabel().then {
        $0.text = "상세 주소 : 대덕소프트웨어마이스터고등학교"
        $0.font = .bodyB2Medium
        $0.textColor = .black900
    }
    private let recruitmentLabel = UILabel().then {
        $0.text = "모집 인원 : 3명 ~ 4명"
        $0.font = .bodyB2Medium
        $0.textColor = .black900
    }
    private let detailsLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.text =
            """
참고 사항 : 이 봉사활동은 이런 점을 우대하고 있고 그리고 또.... 이런 특징을 가지고 있으니 맞지 않는 분들은 지원하지 않는 것이 좋을 것 같습니다!
 🔥 주의 사항 🔥
봉사활동이 많이 빡셀 수도 있어요!! 
참고 사항 : 이 봉사활동은 이런 점을 우대하고 있고 그리고 또.... 이런 특징을 가지고 있으니 맞지 않는 분들은 지원하지 않는 것이 좋을 것 같습니다!
ㅡ니ㅏ어린으러ㅣ너일ㅇㄴ.리너ㅜ리ㅓㄴ얼ㄴ;ㅓㅇㄹ;ㅏㄴㄴㅇ;러니러ㅣㄴ어린리ㅏ너ㅣㅏㅇ러니어리ㅏ느ㅏㅣ츼나으치ㅏ느이ㅏㅜ니ㅏ위ㅏㄴ우피ㅏ뉘ㅏㅜㄴ이ㅏ추니아ㅟㄴ위ㅏㅜㄴ이ㅏㅜ치나우피ㅏㄴ
ㅡ니ㅏ어린으러ㅣ너일ㅇㄴ.리너ㅜ리ㅓㄴ얼ㄴ;ㅓㅇㄹ;ㅏㄴㄴㅇ;러니러ㅣㄴ어린리ㅏ너ㅣㅏㅇ러니어리ㅏ느ㅏㅣ츼나으치ㅏ느이ㅏㅜ니ㅏ위ㅏㄴ우피ㅏ뉘ㅏㅜㄴ이ㅏ추니아ㅟㄴ위ㅏㅜㄴ이ㅏㅜ치나우피ㅏㄴ
ㅏ느ㅏㅣ츼나으치ㅏ느이ㅏㅜ니ㅏ위ㅏㄴ우피ㅏ뉘ㅏㅜㄴ이ㅏ추니아ㅟㄴ
"""
        $0.font = .bodyB2Medium
        $0.textColor = .black900
    }
    private let chatButton = FillButton(type: .system).then {
        $0.setTitle("채팅하기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .black50
        $0.setButtonShadow()
    }
    private let applyButton = FillButton(type: .system).then {
        $0.setTitle("신청하기", for: .normal)
    }

    private func addView() {
        view.addSubview(backgroundView)
        [
            locationImageView,
            titleLabel,
            addressLabel,
            targetLabel,
            detailAddressLabel,
            recruitmentLabel,
            detailsLabel
        ].forEach { backgroundView.addSubview($0) }
        [
            chatButton,
            applyButton
        ].forEach { view.addSubview($0) }
    }
    private func setLayout() {
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
        targetLabel.snp.makeConstraints {
            $0.top.equalTo(locationImageView.snp.bottom).offset(20)
            $0.trailing.leading.equalToSuperview().inset(21)
            $0.height.equalTo(20)
        }
        detailAddressLabel.snp.makeConstraints {
            $0.top.equalTo(targetLabel.snp.bottom)
            $0.trailing.leading.equalToSuperview().inset(21)
            $0.height.equalTo(20)
        }
        recruitmentLabel.snp.makeConstraints {
            $0.top.equalTo(detailAddressLabel.snp.bottom)
            $0.trailing.leading.equalToSuperview().inset(21)
            $0.height.equalTo(20)
        }
        detailsLabel.snp.makeConstraints {
            $0.top.equalTo(recruitmentLabel.snp.bottom).offset(10)
            $0.trailing.leading.equalToSuperview().inset(21)
            $0.bottom.equalToSuperview().inset(20)
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
