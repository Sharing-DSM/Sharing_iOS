import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

open class SharingTextField: UITextField {

    /// nil을 accept하면 오류가 꺼지고 String을 accept하면 오류가 켜집니다
    public var errorMessage = PublishRelay<String?>()

    private let errorLabel = UILabel().then {
        $0.textColor = .error
        $0.font = .bodyB3Medium
        $0.isHidden = true
    }

    private let disposeBag =  DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpTextField()
        bind()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpTextField()
        bind()
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        addSubview(errorLabel)
        errorLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(10)
            $0.top.equalTo(self.snp.bottom).offset(1)
        }
    }

    private func setUpTextField() {
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.black400?.cgColor
        self.font = .bodyB2Medium
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        self.leftViewMode = .always
        self.textColor = .black800
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
        self.setPlaceholderTextColor(color: .black500 ?? .blue)
    }
}

extension SharingTextField {
    private func setPlaceholderTextColor(color: UIColor) {
        
        guard let string = self.placeholder else {
            return
        }
        attributedPlaceholder = NSAttributedString(string: string, attributes: [.foregroundColor: color, .font: UIFont.bodyB2Medium])
    }

    private func bind() {
        self.rx.text.orEmpty
            .map { $0.isEmpty ? UIColor.black400?.cgColor : UIColor.main?.cgColor }
            .subscribe(onNext: { [weak self] color in
                self?.layer.borderColor = color
            })
            .disposed(by: disposeBag)

        errorMessage
            .subscribe(
                onNext: { [weak self] content in
                    self?.errorLabel.isHidden = content == nil
                    guard let content = content else { return }
                    self?.layer.borderColor = UIColor.error?.cgColor
                    self?.errorLabel.text = "* \(content)"
                }
            )
            .disposed(by: disposeBag)
    }

    public func setErrorMessage(_ content: String?) {
        self.errorLabel.text = content
    }
}
