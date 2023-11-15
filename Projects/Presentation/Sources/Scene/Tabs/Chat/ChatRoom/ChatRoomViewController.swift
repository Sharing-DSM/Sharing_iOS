import UIKit
import SnapKit
import Then
import SharingKit
import RxFlow
import RxSwift
import RxCocoa
import Core
import Domain

public class ChatRoomViewController: BaseVC<ChatViewModel> {

    private let headerLabel = UILabel().then {
        $0.text = "김주영"
        $0.textColor = .black900
        $0.font = .headerH2SemiBold
    }

    private let chatScrollerView = UIScrollView().then {
        $0.backgroundColor = .clear
        $0.contentInset = .init(top: 0, left: 0, bottom: 10, right: 0)
    }

    private let chatContentStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 5
    }

    private let sendBackgroundView = UIView().then {
        $0.backgroundColor = .black200
    }

    private let sendChatButton = UIButton(type: .system).then {
        let sendImage: UIImage = .paperAirplane
            .withTintColor(.main!, renderingMode: .alwaysOriginal)
        $0.setImage(sendImage, for: .normal)
    }

    private let chatTextField = UITextField().then {
        $0.font = .bodyB2Medium
        $0.textColor = .black800
        $0.backgroundColor = .black50
        $0.layer.cornerRadius = 23
        $0.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 56, height: 0))
        $0.rightViewMode = .always
        $0.addLeftView()
        $0.setShadow()
    }

    public override func attribute() {
        self.navigationItem.titleView = headerLabel
        keyboardNotification()
        [
            ("hahahahah", "오후 11:09", true),
            ("이건 또 뭐야", "오후 11:09", false),
            ("이건 더미 데이터 인것입니당ㄴ럼;니아러;ㅣㅏasdjhflajshdkflahsdflkashdflkasdhflkasdhjflakshdfkahsdfhaskldfhasdlkjhfaksdjhflasdkjhflaksdjhflasdkjhflaskdjhflakjsdhfalskdhfaskjdhfasdfㅁㄴ얼;ㅣ마ㅓㄴ", "오후 11:09", true),
            ("ㅋㅋㅋㅋㅋㅋㅋㅋㅋ", "오후 11:09", true),
            ("앵..", "오후 11:09", false),
            ("hahahahah", "오후 11:09", true),
            ("이건 또 뭐야", "오후 11:09", false),
            ("이건 더미 데이터 인것입니당ㄴ럼;니아러;ㅣㅏasdjhflajshdkflahsdflkashdflkasdhflkasdhjflakshdfkahsdfhaskldfhasdlkjhfaksdjhflasdkjhflaksdjhflasdkjhflaskdjhflakjsdhfalskdhfaskjdhfasdfㅁㄴ얼;ㅣ마ㅓㄴ", "오후 11:09", true),
            ("ㅋㅋㅋㅋㅋㅋㅋㅋㅋ", "오후 11:09", true),
            ("앵..", "오후 11:09", false),
            ("hahahahah", "오후 11:09", true),
            ("이건 또 뭐야", "오후 11:09", false),
            ("이건 더미 데이터 인것입니당ㄴ럼;니아러;ㅣㅏasdjhflajshdkflahsdflkashdflkasdhflkasdhjflakshdfkahsdfhaskldfhasdlkjhfaksdjhflasdkjhflaksdjhflasdkjhflaskdjhflakjsdhfalskdhfaskjdhfasdfㅁㄴ얼;ㅣ마ㅓㄴ", "오후 11:09", true),
            ("ㅋㅋㅋㅋㅋㅋㅋㅋㅋ", "오후 11:09", true),
            ("앵..", "오후 11:09", false),
            ("hahahahah", "오후 11:09", true),
            ("이건 또 뭐야", "오후 11:09", false),
            ("이건 더미 데이터 인것입니당ㄴ럼;니아러;ㅣㅏasdjhflajshdkflahsdflkashdflkasdhflkasdhjflakshdfkahsdfhaskldfhasdlkjhfaksdjhflasdkjhflaksdjhflasdkjhflaskdjhflakjsdhfalskdhfaskjdhfasdfㅁㄴ얼;ㅣ마ㅓㄴ", "오후 11:09", true),
            ("ㅋㅋㅋㅋㅋㅋㅋㅋㅋ", "오후 11:09", true),
            ("앵..", "오후 11:09", false)
        ].forEach {
            let inputView = $0.2 ?
            MyChatView(content: $0.0, timeLine: $0.1):
            SenderChatView(content: $0.0, timeLine: $0.1)
            chatContentStackView.addArrangedSubview(inputView)
        }
    }

    public override func addView() {
        [
            chatScrollerView,
            sendBackgroundView
        ].forEach({ view.addSubview($0) })
        chatTextField.addSubview(sendChatButton)
        sendBackgroundView.addSubview(chatTextField)
        chatScrollerView.addSubview(chatContentStackView)
    }

    public override func setLayout() {
        sendBackgroundView.snp.makeConstraints {
            $0.width.bottom.equalToSuperview()
            $0.height.equalTo(99)
        }

        chatScrollerView.snp.makeConstraints {
            $0.bottom.greaterThanOrEqualTo(sendBackgroundView.snp.top)
            $0.top.width.equalToSuperview()
        }
        chatContentStackView.snp.makeConstraints {
            $0.top.width.equalToSuperview()
            $0.bottom.equalToSuperview()
        }

        sendChatButton.snp.makeConstraints {
            $0.right.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(30)
        }
        chatTextField.snp.makeConstraints {
            $0.height.equalTo(46)
            $0.left.right.equalToSuperview().inset(25)
            $0.top.equalToSuperview().inset(5)
        }
    }

    private func keyboardNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardControl(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardControl(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc func keyboardControl(_ sender: Notification) {
        guard let userInfo = sender.userInfo else { return }
        guard let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else { return }

        if sender.name == UIResponder.keyboardWillShowNotification {
            let moveTo = -keyboardFrame.height + view.safeAreaInsets.bottom + 10
            [
                sendBackgroundView,
                chatScrollerView
            ].forEach { $0.transform = CGAffineTransform(translationX: 0, y: moveTo) }
        } else {
            [
                sendBackgroundView,
                chatScrollerView
            ].forEach { $0.transform = .identity }
        }
    }
}
