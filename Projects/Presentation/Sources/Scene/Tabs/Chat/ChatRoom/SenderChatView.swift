import UIKit
import SharingKit
import SnapKit
import Then
import Core

class SenderChatView: UIView {

    private let chatBackground = UIView().then {
        $0.backgroundColor = .main
        $0.layer.cornerRadius = 14
    }

    private let contentLabel = UILabel().then {
        $0.font = .bodyB3Medium
        $0.textColor = .white
        $0.numberOfLines = 0
    }

    private let timeLabel = UILabel().then {
        $0.font = .bodyB3SemiBold
        $0.textColor = .black600
        $0.textAlignment = .left
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
            $0.left.equalToSuperview().inset(16)
            $0.height.greaterThanOrEqualTo(18)
        }
        timeLabel.snp.makeConstraints {
            $0.bottom.equalTo(chatBackground)
            $0.left.equalTo(chatBackground.snp.right).offset(5)
            $0.height.equalTo(18)
        }
        chatBackground.snp.makeConstraints {
            $0.right.equalTo(contentLabel).offset(16)
            $0.left.equalToSuperview().inset(25)
            $0.bottom.equalTo(contentLabel).offset(5)
            $0.width.lessThanOrEqualTo(260)
        }
        self.snp.makeConstraints {
            $0.top.bottom.equalTo(chatBackground)
        }
    }
}
