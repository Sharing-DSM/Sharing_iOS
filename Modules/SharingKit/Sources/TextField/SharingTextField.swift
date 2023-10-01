import UIKit
import RxSwift
import RxCocoa

open class SharingTextField: UITextField {

    private let disposeBag =  DisposeBag()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpTextField()
        changeBorderColor()
        changeBorderColor()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpTextField()
        changeBorderColor()
        changeBorderColor()
    }
    private func setUpTextField() {
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.black400?.cgColor
        self.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        self.leftViewMode = .always
        self.textColor = .black800
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

    private func changeBorderColor() {
        self.rx.text.orEmpty
            .map { $0.isEmpty ? UIColor.black400?.cgColor : UIColor.main?.cgColor }
                .subscribe(onNext: { [weak self] color in
                self?.layer.borderColor = color
                })
                .disposed(by: disposeBag)
    }
}
