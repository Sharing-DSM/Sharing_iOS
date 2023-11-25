import UIKit
import SharingKit
import SnapKit
import Then
import Kingfisher

class ChatTableViewCell: UITableViewCell {

    static let Identifier = "ChatTableViewCell"

    public var roomID: String = ""

    public var isDidNotRead: Bool = false {
        didSet {
            backgroundColor = isDidNotRead ? .black50 : .white
            previewLabel.font = isDidNotRead ? .bodyB3SemiBold : .bodyB3Medium
            previewLabel.textColor = isDidNotRead ? .black900 : .black700
            dotView.isHidden = !isDidNotRead
        }
    }

    private let profileImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .black100
        $0.layer.cornerRadius = 30
        $0.clipsToBounds = true
    }

    private let nameLabel = UILabel().then {
        $0.text = "-"
        $0.textColor = .black900
        $0.font = .bodyB1SemiBold
    }

    private let previewLabel = UILabel().then {
        $0.text = "-"
        $0.textColor = .black700
        $0.font = .bodyB3Medium
    }

    private let timeLineLabel = UILabel().then {
        $0.text = "・"
        $0.textColor = .black600
        $0.font = .bodyB3SemiBold
    }

    private let dotView = UIView().then {
        $0.backgroundColor = .main
        $0.layer.cornerRadius = 3
        $0.isHidden = true
    }

    public func setup(
        imageURL: String,
        roomName: String,
        preview: String,
        sendAt: String,
        roomID: String
    ) {
        if imageURL.isEmpty { profileImageView.image = .profileImage }
        else { profileImageView.kf.setImage(with: URL(string: imageURL))}

        nameLabel.text = roomName
        previewLabel.text = preview
        timeLineLabel.text = "・\(sendAt)"
        self.roomID = roomID
        
        addView()
        setLayout()
    }

    private func addView() {
        [
            profileImageView,
            nameLabel,
            previewLabel,
            timeLineLabel,
            dotView
        ].forEach({ addSubview($0) })
    }

    private func setLayout() {
        profileImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(15)
            $0.left.equalToSuperview().inset(16)
            $0.width.height.equalTo(60)
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(21)
            $0.left.equalTo(profileImageView.snp.right).offset(15)
            $0.height.equalTo(22)
        }
        previewLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(3)
            $0.left.equalTo(nameLabel)
            $0.right.equalToSuperview().inset(90)
            $0.height.equalTo(18)
        }
        timeLineLabel.snp.makeConstraints {
            $0.centerY.equalTo(nameLabel)
            $0.left.equalTo(nameLabel.snp.right)
            $0.height.equalTo(18)
        }
        dotView.snp.makeConstraints {
            $0.centerY.equalTo(timeLineLabel)
            $0.left.equalTo(timeLineLabel.snp.right).offset(8)
            $0.height.width.equalTo(6)
        }
    }
}
