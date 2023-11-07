import UIKit
import RxSwift
import RxCocoa

open class ToggleButton: UIButton {

    public var isActivate = BehaviorRelay<Bool>(value: false)

    private let disposeBag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpButton()
        bind()
     }
     
    required public init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
         setUpButton()
     }
}

extension ToggleButton {

    private func setUpButton() {
        self.backgroundColor = .main
        self.layer.cornerRadius = 3
        self.setBackgroundImage(.toggleDisabled, for: .normal)
        self.setShadow()
    }

    private func bind() {
        self.rx.tap
            .subscribe(
                with: self,
                onNext: { owner, _ in
                    let status = owner.isActivate.value
                    owner.isActivate.accept(!status)
                }
            )
            .disposed(by: disposeBag)

        isActivate
            .subscribe(
                with: self,
                onNext: { owner, status in
                    status ? owner.activate() : owner.disabled()
                }
            )
            .disposed(by: disposeBag)
    }

    private func disabled() {
        self.setBackgroundImage(.toggleDisabled, for: .normal)
    }

    private func activate() {
        self.setBackgroundImage(.toggleActivate, for: .normal)
    }
}
