import UIKit
import SnapKit
import Then
import SharingKit

class AreaOfInterstCollectionViewCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 10
        self.backgroundColor = .black50
        self.setShadow()
        addView()
        setLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    let titleLabel = UILabel().then {
        $0.text = "어르신 휠체어 이동 도움 및 보조 활동"
        $0.font = .bodyB2SemiBold
        $0.textColor = .black900
    }
    let addressLabel = UILabel().then {
        $0.text = "유성구 전민동"
        $0.font = .bodyB3Medium
        $0.textColor = .black600
    }

    func addView() {
        [
            titleLabel,
            addressLabel
        ].forEach { self.addSubview($0) }
    }
    func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(20)
        }
        addressLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.equalTo(titleLabel)
            $0.height.equalTo(18)
        }
    }
}
