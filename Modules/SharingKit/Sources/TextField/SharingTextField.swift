import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

open class SharingTextField: UITextField {

    /// nil을 accept하면 오류가 꺼지고 String을 accept하면 오류가 켜집니다
    public var errorMessage = PublishRelay<String?>()

    public var isSecurity: Bool = false {
        didSet {
            textHideButton.isHidden = !isSecurity
            self.isSecureTextEntry = true
            self.addLeftAndRightView()
        }
    }

    private let titleLabel = UILabel().then {
        $0.textColor = .black900
        $0.font = .bodyB2Medium
    }

    private let errorLabel = UILabel().then {
        $0.textColor = .error
        $0.font = .bodyB3Medium
    }

    private let textHideButton = UIButton().then {
        $0.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        $0.tintColor = .gray
        $0.contentMode = .scaleAspectFit
        $0.isHidden = true
    }

    private let disposeBag =  DisposeBag()
    
    public init(title: String? = nil) {
        super.init(frame: .zero)
        self.titleLabel.text = title
        setUpTextField()
        bind()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        [
            errorLabel,
            textHideButton,
            titleLabel
        ].forEach { addSubview($0) }

        errorLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(10)
            $0.top.equalTo(self.snp.bottom).offset(1)
        }
        textHideButton.snp.makeConstraints {
            $0.right.equalToSuperview().inset(5)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(30)
        }
        titleLabel.snp.makeConstraints {
            $0.bottom.equalTo(self.snp.top)
            $0.left.equalToSuperview()
            $0.height.equalTo(20)
        }
        self.setPlaceholderTextColor(color: .black500 ?? .blue)
    }
    
    private func setUpTextField() {
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.black400?.cgColor
        self.font = .bodyB2Medium
        self.addLeftView()
        self.addRightView()
        self.textColor = .black800
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
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
    
        textHideButton.rx.tap.subscribe(onNext:{ [weak self] in
            self?.isSecureTextEntry.toggle()
            let imageName = (self?.isSecureTextEntry ?? false) ? "eye.fill" : "eye.slash.fill"
            self?.textHideButton.setImage(UIImage(systemName:imageName), for:.normal)
        }).disposed(by: disposeBag)
        
    }
    
    public func setErrorMessage(_ content: String?) {
        self.errorLabel.text = content
    }
}
