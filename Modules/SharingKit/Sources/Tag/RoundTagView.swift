import UIKit
import SnapKit
import Then
  
public class RoundTagView: UIView {

    private let tagLabel = UILabel().then {
        $0.textColor = .black50
        $0.font = .bodyB3Medium
    }

    public init(tag: String? = nil) {
        super.init(frame: .zero)
        self.tagLabel.text = "# \(tag ?? "")"
        backgroundColor = .main
        layer.cornerRadius = 12
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        addSubview(tagLabel)
        self.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.right.equalTo(tagLabel.snp.right).offset(13)
        }

        tagLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(13)
        }
    }
}
