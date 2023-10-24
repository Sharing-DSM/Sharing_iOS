import UIKit
import SharingKit
import SnapKit
import Then

class MapPostTableViewCell: UITableViewCell {

    private let postTitleLable = UILabel().then {
        $0.textColor = .black900
        $0.font = .bodyB2SemiBold
    }

    private let addressLable = UILabel().then {
        $0.textColor = .black600
        $0.font = .bodyB3Medium
    }

    private let cellBackgroundView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.layer.shadowColor = UIColor.black.withAlphaComponent(0.25).cgColor
        $0.layer.shadowRadius = 4
    }

    private let tagsView = TagScrollView()

    public func settingCell(
        title: String?,
        address: String?,
        tags: [String]? = nil
    ) {
        self.postTitleLable.text = title
        self.addressLable.text = address
        self.tagsView.tags = tags
    }

    override func layoutSubviews() {
        addSubview(cellBackgroundView)
        [
            postTitleLable,
            addressLable,
            tagsView
        ].forEach { cellBackgroundView.addSubview($0) }

        cellBackgroundView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(26)
            $0.height.greaterThanOrEqualTo(90)
            $0.bottom.equalTo(tagsView.snp.bottom).offset(12)
        }
        postTitleLable.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.left.right.equalToSuperview().inset(20)
        }
        addressLable.snp.makeConstraints {
            $0.top.equalTo(postTitleLable.snp.bottom)
            $0.left.right.equalToSuperview().inset(20)
        }
        tagsView.snp.makeConstraints {
            $0.top.equalTo(addressLable.snp.bottom).offset(5)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(25)
        }
    }
}
