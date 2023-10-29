import UIKit
import Then
import SnapKit
import SharingKit

class BannerView: UIView {

    let titleLabel = UILabel().then {
        $0.text = "긴급 화재 발생"
        $0.font = .headerH3SemiBold
        $0.textColor = .main
    }
    let subTitleLabel = UILabel().then {
        $0.text = "화재현장 도우미 모집"
        $0.font = .headerH3SemiBold
        $0.textColor = .black
        
    }
    let aderessLabel = UILabel().then {
        $0.text = "대전광역시 유성구 (대덕소프트웨어마이스터고등학교)"
        $0.font = .bodyB3Medium
        $0.textColor = .black700
    }

    override func layoutSubviews() {
        addView()
        setLayout()
    }

    func addView() {
        [
            titleLabel,
            subTitleLabel,
            aderessLabel
        ].forEach { self.addSubview($0)}
    }

    func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(26)
        }
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(1)
            $0.leading.equalTo(titleLabel)
            $0.height.equalTo(26)
        }
        aderessLabel.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(3)
            $0.leading.equalTo(titleLabel)
            $0.height.equalTo(18)
        }
    }
}
