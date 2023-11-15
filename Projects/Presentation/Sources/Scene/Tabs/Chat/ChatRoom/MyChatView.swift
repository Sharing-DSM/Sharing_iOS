import UIKit
import SharingKit
import SnapKit
import Then
import Core

class MyChatView: UIView {

    private let chatBackground = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 14
        $0.layer.borderWidth = 0.7
        $0.layer.borderColor = UIColor.main?.cgColor
    }

    private let contentLabel = UILabel().then {
        $0.font = .bodyB3Medium
        $0.textColor = .main
        $0.numberOfLines = 0
    }

    private let timeLabel = UILabel().then {
        $0.font = .bodyB3SemiBold
        $0.textColor = .black600
        $0.textAlignment = .right
    }

    init(
        content: String,
        timeLine: String
    ) {
        super.init(frame: .zero)
        self.contentLabel.text = content
        self.timeLabel.text = timeLine
        addView()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addView() {
        [
            timeLabel,
            chatBackground
        ].forEach({ addSubview($0) })
        chatBackground.addSubview(contentLabel)
    }

    private func setLayout() {
        contentLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(5)
            $0.right.equalToSuperview().inset(16)
            $0.height.greaterThanOrEqualTo(18)
        }
        timeLabel.snp.makeConstraints {
            $0.bottom.equalTo(chatBackground)
            $0.right.equalTo(chatBackground.snp.left).offset(-5)
            $0.height.equalTo(18)
        }
        chatBackground.snp.makeConstraints {
            $0.left.equalTo(contentLabel).offset(-16)
            $0.right.equalToSuperview().inset(25)
            $0.bottom.equalTo(contentLabel).offset(5)
            $0.width.lessThanOrEqualTo(260)
        }
        self.snp.makeConstraints {
            $0.top.bottom.equalTo(chatBackground)
        }
    }
}
