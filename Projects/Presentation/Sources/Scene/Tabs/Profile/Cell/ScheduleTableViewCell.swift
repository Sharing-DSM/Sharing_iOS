import UIKit
import SnapKit
import Then
import SharingKit
import RxCocoa
import RxSwift

class ScheduleTableViewCell: UITableViewCell {

    let disposeBag = DisposeBag()

    static let id: String = "mapPostTableViewCell.id"

    private let cellBackgroundView = UIView().then {
        $0.backgroundColor = .black50
        $0.layer.cornerRadius = 10
        $0.setShadow()
    }
    private let titleLabel = UILabel().then {
        $0.text = "어르신 휠체어 이동 보조 활동"
        $0.font = .bodyB1Bold
        $0.textColor = .black900
    }
    private let dateLabel = UILabel().then {
        $0.text = "2023년 11월 31일"
        $0.font = .bodyB1Regular
        $0.textColor = .black700
    }
    private let checkBoxButton = UIButton(type: .system).then {
        $0.setImage(SharingKitAsset.Image.checkmarkIcon.image, for: .normal)
        $0.backgroundColor = .black50
        $0.tintColor = .black400
        $0.layer.cornerRadius = 3
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black400?.cgColor
    }
    private let menuButton = UIButton().then {
        $0.setImage(UIImage(named: "ellipsis.vertical"), for: .normal)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(cellBackgroundView)
        [
            titleLabel,
            dateLabel,
            checkBoxButton,
            menuButton
        ].forEach { cellBackgroundView.addSubview($0) }

        cellBackgroundView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(2)
            $0.left.right.equalToSuperview().inset(25)
            $0.height.greaterThanOrEqualTo(75)
            $0.bottom.equalTo(dateLabel.snp.bottom).offset(13)
    
        }
        titleLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview().inset(16)
            $0.right.equalTo(checkBoxButton.snp.right).offset(17)
            $0.height.equalTo(17)
        }
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.left.equalToSuperview().inset(16)
            $0.right.equalTo(checkBoxButton.snp.left).offset(18)
        }
        checkBoxButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(25)
            $0.right.equalTo(menuButton.snp.left).offset(8)
            $0.width.height.equalTo(25)
        }
        menuButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(28)
            $0.right.equalToSuperview().inset(8)
            $0.width.height.equalTo(20)
        }
        checkBoxButton.rx.tap
            .subscribe(onNext: { [weak self] in
                let isBlack = self?.checkBoxButton.backgroundColor == .black50
                self?.checkBoxButton.backgroundColor = isBlack ? .main : .black50
                self?.checkBoxButton.tintColor = isBlack ? .white : .black400
            })
            .disposed(by: disposeBag)

    }
}
