import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import Core

public class TagsSelectView: UIView {
    
    private let disposeBag = DisposeBag()
    
    public var selectTagType = BehaviorRelay<TagTypeEnum>(value: .NONE)
    
    private let naturalTagButton = UIButton(type: .system).then {
        $0.setTitle("#환경(자연)", for: .normal)
        $0.setTitleColor(.black50, for: .normal)
        $0.titleLabel?.font = UIFont.bodyB3Medium
        $0.backgroundColor = .black400
        $0.layer.cornerRadius = 13
    }
    private let educationTagButton = UIButton(type: .system).then {
        $0.setTitle("#교육", for: .normal)
        $0.setTitleColor(.black50, for: .normal)
        $0.titleLabel?.font = UIFont.bodyB3Medium
        $0.backgroundColor = .black400
        $0.layer.cornerRadius = 13
    }
    private let societyTagButton = UIButton(type: .system).then {
        $0.setTitle("#사회", for: .normal)
        $0.setTitleColor(.black50, for: .normal)
        $0.titleLabel?.font = UIFont.bodyB3Medium
        $0.backgroundColor = .black400
        $0.layer.cornerRadius = 13
    }
    private let cultureTagButton = UIButton(type: .system).then {
        $0.setTitle("#문화", for: .normal)
        $0.setTitleColor(.black50, for: .normal)
        $0.titleLabel?.font = UIFont.bodyB3Medium
        $0.backgroundColor = .black400
        $0.layer.cornerRadius = 13
    }
    private let ectTagButton = UIButton(type: .system).then {
        $0.setTitle("#기타", for: .normal)
        $0.setTitleColor(.black50, for: .normal)
        $0.titleLabel?.font = UIFont.bodyB3Medium
        $0.backgroundColor = .black400
        $0.layer.cornerRadius = 13
    }
    private let tagsStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .leading
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        naturalTagButton.rx.tap
            .subscribe(
                with: self,
                onNext: { owner, _ in
                    owner.selectButton(button: owner.naturalTagButton, type: .NATURAL)
                }
            )
            .disposed(by: disposeBag)
        educationTagButton.rx.tap
            .subscribe(
                with: self,
                onNext: { owner, _ in
                    owner.selectButton(button: owner.educationTagButton, type: .EDUCATION)
                }
            )
            .disposed(by: disposeBag)
        societyTagButton.rx.tap
            .subscribe(
                with: self,
                onNext: { owner, _ in
                    owner.selectButton(button: owner.societyTagButton, type: .SOCIAL)
                }
            )
            .disposed(by: disposeBag)
        cultureTagButton.rx.tap
            .subscribe(
                with: self,
                onNext: { owner, _ in
                    owner.selectButton(button: owner.cultureTagButton, type: .CULTURE)
                }
            )
            .disposed(by: disposeBag)
        ectTagButton.rx.tap
            .subscribe(
                with: self,
                onNext: { owner, _ in
                    owner.selectButton(button: owner.ectTagButton, type: .ETC)
                }
            )
            .disposed(by: disposeBag)
    }

    private func selectButton(button: UIButton, type: TagTypeEnum) {
        selectTagType.accept(type)
        [
            naturalTagButton,
            educationTagButton,
            societyTagButton,
            cultureTagButton,
            ectTagButton
        ].forEach {
            if button == $0 { $0.backgroundColor = .main }
            else { $0.backgroundColor = .black400 }
        }
    }

    public override func layoutSubviews() {
        addSubview(tagsStackView)
        [
            naturalTagButton,
            educationTagButton,
            societyTagButton,
            cultureTagButton,
            ectTagButton
        ].forEach { tagsStackView.addArrangedSubview($0) }

        tagsStackView.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
        }
        naturalTagButton.snp.makeConstraints {
            $0.height.equalTo(26)
            $0.width.equalTo(84)
        }
        educationTagButton.snp.makeConstraints {
            $0.height.equalTo(26)
            $0.width.equalTo(54)
        }
        societyTagButton.snp.makeConstraints {
            $0.height.equalTo(26)
            $0.width.equalTo(54)
        }
        cultureTagButton.snp.makeConstraints {
            $0.height.equalTo(26)
            $0.width.equalTo(54)
        }
        ectTagButton.snp.makeConstraints {
            $0.height.equalTo(26)
            $0.width.equalTo(54)
        }
    }
}
