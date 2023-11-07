import UIKit
import SharingKit
import SnapKit
import Then
import Domain

class AddressTableViewCell: UITableViewCell {

    static let identifier = "AddressTableViewCell"

    var addressData = AddressEntityElement(
        x: 0.0,
        y: 0.0,
        addressName: "",
        roadAddressName: "",
        buildingName: ""
    )

    private let roadAddressMarkLabel = UILabel().then {
        $0.text = "도로명"
        $0.textColor = .black900
        $0.font = .bodyB1SemiBold
    }
    let roadAddressLabel = UILabel().then {
        $0.text = "대전광역시 유성구 가정북로 76 (대덕소프트웨어마이스터고등학교)"
        $0.textColor = .black800
        $0.font = .bodyB2Medium
        $0.numberOfLines = 0
    }
    private let addressNameMarkLabel = UILabel().then {
        $0.text = "지번"
        $0.textColor = .black700
        $0.font = .bodyB1SemiBold
    }
    let addressNameLabel = UILabel().then {
        $0.text = "대충 지번 넣기..... 대충 지번 넣기..... 대충 지번 넣기....."
        $0.textColor = .black600
        $0.font = .bodyB2Medium
        $0.numberOfLines = 0
    }

    func setup() {
        backgroundColor = .black50
        addView()
        setLayout()
    }

    private func addView() {
        [
            roadAddressMarkLabel,
            roadAddressLabel,
            addressNameMarkLabel,
            addressNameLabel
        ].forEach { addSubview($0) }
    }

    private func setLayout() {
        roadAddressMarkLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(20)
            $0.height.equalTo(22)
            $0.width.equalTo(44)
        }
        roadAddressLabel.snp.makeConstraints {
            $0.leading.equalTo(roadAddressMarkLabel.snp.trailing).offset(9)
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalTo(roadAddressMarkLabel)
            $0.height.greaterThanOrEqualTo(20)
        }
        addressNameMarkLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(roadAddressLabel.snp.bottom).offset(10)
            $0.height.equalTo(22)
        }
        addressNameLabel.snp.makeConstraints {
            $0.leading.equalTo(roadAddressLabel)
            $0.trailing.equalToSuperview().inset(20) 
            $0.centerY.equalTo(addressNameMarkLabel)
            $0.height.greaterThanOrEqualTo(20)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
}
