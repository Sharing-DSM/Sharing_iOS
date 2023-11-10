import UIKit
import SharingKit
import SnapKit
import Then

class PostTableViewCell: UITableViewCell {

    static let identifier: String = "mapPostTableViewCell.id"

    public var cellId: String? = nil

    let postTitleLable = UILabel().then {
        $0.textColor = .black900
        $0.font = .bodyB2SemiBold
    }

    let addressLable = UILabel().then {
        $0.textColor = .black600
        $0.font = .bodyB3Medium
    }

    let cellBackgroundView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.layer.shadowColor = UIColor.black.withAlphaComponent(0.25).cgColor
        $0.layer.shadowRadius = 4
        $0.setShadow()
    }

    let tagView = RoundTagView()

    public func setup() {
        self.backgroundColor = .clear
        self.selectionStyle = .none

        addSubview(cellBackgroundView)
        [
            postTitleLable,
            addressLable,
            tagView
        ].forEach { cellBackgroundView.addSubview($0) }

        cellBackgroundView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.left.right.equalToSuperview().inset(26)
            $0.bottom.equalToSuperview().offset(-5)
            $0.bottom.greaterThanOrEqualTo(tagView.snp.bottom).offset(12)
        }
        postTitleLable.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.left.right.equalToSuperview().inset(20)
        }
        addressLable.snp.makeConstraints {
            $0.top.equalTo(postTitleLable.snp.bottom)
            $0.left.right.equalToSuperview().inset(20)
        }
        tagView.snp.makeConstraints {
            $0.top.equalTo(addressLable.snp.bottom).offset(5)
            $0.left.equalToSuperview().inset(20)
        }
    }
}
