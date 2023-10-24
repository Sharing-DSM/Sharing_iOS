import UIKit
import SnapKit
import Then

public class SearchBarTextField: UITextField {

    public let searchButton = UIButton(type: .system).then {
        $0.setImage(SharingKitAsset.Image.search.image, for: .normal)
    }

    public init() {
        super.init(frame: .zero)
        self.backgroundColor = .black50
        self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: 0))
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        self.leftViewMode = .always
        self.rightViewMode = .always
        self.layer.cornerRadius = 25
        self.font = .bodyB2Medium
        self.textColor = .black900
        setPlaceholderTextColor(color: .black50 ?? .black)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(searchButton)
        searchButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(20)
        }
        self.snp.makeConstraints {
            $0.height.equalTo(50)
        }
    }
}

extension SearchBarTextField {
    private func setPlaceholderTextColor(color: UIColor) {
        guard let string = self.placeholder else { return }
        attributedPlaceholder = NSAttributedString(
            string: string,
            attributes: [.foregroundColor: color, .font: UIFont.bodyB2Medium]
        )
    }
}
