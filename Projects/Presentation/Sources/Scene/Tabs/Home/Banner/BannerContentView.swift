import UIKit
import Then
import SnapKit
import SharingKit

class BannerContentView: UIView {

    let highlightTitleLabel = UILabel().then {
        $0.text = "'긴급'"
        $0.font = .headerH3SemiBold
        $0.textColor = .error
    }

    let titleLabel = UILabel().then {
        $0.text = "봉사 인원 모집합니다"
        $0.font = .headerH3SemiBold
        $0.textColor = .main
    }
    let subTitleLabel = UILabel().then {
        $0.font = .headerH3SemiBold
        $0.textColor = .black
        
    }
    let aderessLabel = UILabel().then {
        $0.font = .bodyB3Medium
        $0.textColor = .black700
    }

    init() {
        super.init(frame: .zero)
        backgroundColor = .clear
        addView()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addView() {
        [
            highlightTitleLabel,
            titleLabel,
            subTitleLabel,
            aderessLabel
        ].forEach { self.addSubview($0) }
    }

    func setLayout() {
        highlightTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(26)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(highlightTitleLabel)
            $0.leading.equalTo(highlightTitleLabel.snp.trailing).offset(5)
            $0.height.equalTo(26)
        }
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(highlightTitleLabel.snp.bottom).offset(1)
            $0.leading.equalTo(highlightTitleLabel)
            $0.height.equalTo(26)
        }
        aderessLabel.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(3)
            $0.leading.equalTo(highlightTitleLabel)
            $0.height.equalTo(18)
        }
        self.snp.makeConstraints {
            $0.height.equalTo(103)
        }
    }
}
