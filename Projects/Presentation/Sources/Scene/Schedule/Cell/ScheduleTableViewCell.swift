import UIKit
import SnapKit
import Then
import SharingKit
import RxCocoa
import RxSwift

public protocol ScheduleTableViewCellDelegate: AnyObject {
    func didTapDeleteButton(cellId: String)
    func didTapEditButton(cellId: String)
    func checkBoxButtonDidTap(cellId: String)
}

public class ScheduleTableViewCell: UITableViewCell {

    static let identifier = "ScheduleTableViewCell"

    var disposeBag = DisposeBag()
    weak var delegate: ScheduleTableViewCellDelegate?
    public var cellId: String? = nil

    let cellBackgroundView = UIView().then {
        $0.backgroundColor = .black50
        $0.layer.cornerRadius = 10
        $0.setShadow()
    }
    let titleLabel = UILabel().then {
        $0.font = .bodyB1Bold
        $0.textColor = .black900
    }
    let dateLabel = UILabel().then {
        $0.font = .bodyB1Regular
        $0.textColor = .black700
    }
    lazy var checkBoxButton = UIButton(type: .system).then {
        $0.setImage(SharingKitAsset.Image.checkmarkIcon.image, for: .normal)
        $0.backgroundColor = .black50
        $0.tintColor = .black400
        $0.layer.cornerRadius = 3
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black400?.cgColor
    }
    private let interactionButton = UIButton(type: .system).then {
        $0.setImage(.interactionDot.withTintColor(.black700!, renderingMode: .alwaysOriginal), for: .normal)
        $0.showsMenuAsPrimaryAction = true
    }
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpControl()
        bind()
        contentView.isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func bind() {
        checkBoxButton.rx.tap
            .bind { [unowned self] in
                self.delegate?.checkBoxButtonDidTap(cellId: cellId ?? "")
                checkBoxButton.backgroundColor = .main
            }.disposed(by: disposeBag)
    }
    func setUpControl()  {
        let deleteAction = UIAction(
            title: "삭제하기",
            image: UIImage(systemName: "trash"),
            attributes: .destructive,
            handler: { [weak self] _ in
                self?.delegate?.didTapDeleteButton(cellId: self?.cellId ?? "")
        })
        let editAction = UIAction(
            title: "수정하기",
            image: UIImage(systemName: "pencil"),
            handler: { [weak self] _ in
            self?.delegate?.didTapEditButton(cellId: self?.cellId ?? "")
        })
        let menu = UIMenu(children: [deleteAction, editAction])
        interactionButton.menu = menu
    }

    public func setup() {
        self.selectionStyle = .none
        addSubview(cellBackgroundView)
        [
            titleLabel,
            dateLabel,
            checkBoxButton,
            interactionButton
        ].forEach { cellBackgroundView.addSubview($0) }

        cellBackgroundView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(2)
            $0.left.right.equalToSuperview().inset(25)
            $0.height.greaterThanOrEqualTo(75)
            $0.bottom.equalTo(dateLabel.snp.bottom).offset(13)
            $0.bottom.equalToSuperview().offset(-8)
        }
        titleLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview().inset(16)
            $0.right.equalTo(checkBoxButton.snp.right).offset(17)
            $0.height.equalTo(20)
        }
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.left.equalToSuperview().inset(16)
            $0.right.equalTo(checkBoxButton.snp.left).offset(18)
        }
        checkBoxButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalTo(interactionButton.snp.left).offset(-8)
            $0.width.height.equalTo(25)
        }
        interactionButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(8)
            $0.width.height.equalTo(20)
        }
    }
}

