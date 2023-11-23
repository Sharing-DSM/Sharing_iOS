import UIKit
import SharingKit
import Kingfisher

class ApplicantListCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "ApplicantListCollectionViewCell"

    private let profileImageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 25
        $0.backgroundColor = .black100
        $0.setShadow()
    }

    private let nameLabel = UILabel().then {
        $0.text = "김주영"
        $0.textColor = .black900
        $0.textAlignment = .center
        $0.font = .bodyB3SemiBold
    }

    private let idLabel = UILabel().then {
        $0.text = "@jyk1029"
        $0.textColor = .black600
        $0.textAlignment = .center
        $0.font = .captionC2Medium
    }

    private let seperaterView = UIView().then {
        $0.backgroundColor = .black400
    }

    private let applicationDateMarkLabel = UILabel().then {
        $0.text = "신청일"
        $0.textColor = .black800
        $0.font = .captionC1Medium
    }

    private let applicationDateLabel = UILabel().then {
        $0.text = "2023.11.20"
        $0.textColor = .main
        $0.textAlignment = .center
        $0.font = .captionC1SemiBold
    }

    public func setup(
        profileImageLink: String,
        name: String,
        identifier: String,
        applicantAt: String
    ) {
        profileImageView.kf.setImage(with: URL(string: profileImageLink))
        nameLabel.text = name
        idLabel.text = "@\(identifier)"
        applicationDateLabel.text = applicantAt

        backgroundColor = .white
        layer.cornerRadius = 10
        setShadow()
        addView()
        setLayout()
    }

    private func addView() {
        [
            profileImageView,
            nameLabel,
            idLabel,
            seperaterView,
            applicationDateMarkLabel,
            applicationDateLabel
        ].forEach { addSubview($0) }
    }

    private func setLayout() {
        profileImageView.snp.makeConstraints {
            $0.width.height.equalTo(50)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(8)
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom)
            $0.left.right.equalToSuperview().inset(5)
            $0.height.equalTo(18)
        }
        idLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom)
            $0.left.right.equalToSuperview().inset(5)
        }
        seperaterView.snp.makeConstraints {
            $0.top.equalTo(idLabel.snp.bottom).offset(5)
            $0.height.equalTo(1)
            $0.left.right.equalToSuperview()
        }
        applicationDateMarkLabel.snp.makeConstraints {
            $0.top.equalTo(seperaterView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(14)
        }
        applicationDateLabel.snp.makeConstraints {
            $0.top.equalTo(applicationDateMarkLabel.snp.bottom)
            $0.bottom.equalToSuperview().inset(8)
            $0.left.right.equalToSuperview().inset(5)
            $0.height.equalTo(14)
        }
    }
}
