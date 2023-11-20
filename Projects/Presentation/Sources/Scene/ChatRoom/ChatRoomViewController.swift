import UIKit
import SnapKit
import Then
import SharingKit
import RxFlow
import RxSwift
import RxCocoa
import Core
import Domain

public class ChatRoomViewController: BaseVC<ChatRoomViewModel> {
    
    public var roomID: String = ""
    
    private let fetchChatContent = PublishRelay<String>()
    private let joinRoom = PublishRelay<String>()
    private let exitRoom = PublishRelay<Void>()
    private let sendChatting = PublishRelay<String>()
    
    private let navigationBarBackgroundView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private let placeHolderImageView = UIImageView().then {
        $0.image = .pencilInMessage
        $0.tintColor = .black400
        $0.isHidden = true
    }
    
    private let placeHolderLabel = UILabel().then {
        $0.textColor = .black400
        $0.font = .bodyB2SemiBold
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.isHidden = true
    }
    
    private let headerLabel = UILabel().then {
        $0.textColor = .black900
        $0.font = .headerH2SemiBold
    }
    
    private let scrollBackgroundView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private let chatScrollerView = UIScrollView().then {
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
        $0.contentInset = .init(top: 10, left: 0, bottom: 20, right: 0)
        $0.transform = .init(rotationAngle: .pi)
        $0.keyboardDismissMode = .interactive
    }
    
    private let chatContentStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 5
        $0.transform = .init(rotationAngle: .pi)
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
    
    public override func viewDidAppear(_ animated: Bool) {
        joinRoom.accept(roomID)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        self.exitRoom.accept(())
    }
    
    public override func attribute() {
        fetchChatContent.accept(roomID)
        keyboardNotification()
        settingDissmissGesture(target: [chatContentStackView])
    }
    
    public override func bind() {
        
        let input = ChatRoomViewModel.Input(
            fetchChatContent: fetchChatContent.asObservable(),
            joinChatRoom: joinRoom.asObservable(),
            exitChatRoom: exitRoom.asObservable(),
            sendChatting: sendChatting.asObservable()
        )
        let output = viewModel.transform(input: input)
        
        output.chattingMassage.asObservable()
            .subscribe(
                with: self,
                onNext: { owner, content in
                    let inputView = content.isMine ?
                    MyChatView(content: content.message, timeLine: content.sendAt):
                    SenderChatView(content: content.message, timeLine: content.sendAt)
                    owner.chatContentStackView.addArrangedSubview(inputView)
                }
            )
            .disposed(by: disposeBag)
        
        sendChatButton.rx.tap
            .compactMap { self.chatTextField.text }
            .filter { !$0.isEmpty }
            .subscribe(
                with: self,
                onNext: { owner, content in
                    owner.sendChatting.accept(content)
                    owner.chatTextField.text = ""
                }
            )
            .disposed(by: disposeBag)

        sendChatting.asObservable()
            .subscribe(
                with: self,
                onNext: { owner, _ in
                    owner.placeHolderImageView.isHidden = true
                    owner.placeHolderLabel.isHidden = true
                }
            )
            .disposed(by: disposeBag)

        output.joinRoom.asObservable()
            .map { $0.chats.isEmpty }
            .subscribe(
                with: self,
                onNext: { owner, status in
                    owner.placeHolderImageView.isHidden = !status
                    owner.placeHolderLabel.isHidden = !status
                }
            )
            .disposed(by: disposeBag)
        
        output.joinRoom.asObservable()
            .subscribe(
                with: self,
                onNext: { owner, data in
                    print(data.userName)
                    owner.headerLabel.text = data.userName
                    owner.navigationItem.titleView = owner.headerLabel
                    owner.placeHolderLabel.text = "메시지를 보내어\n\(data.userName)님과의 소통을 시작하세요!"
                    data.chats.forEach {
                        let inputView = $0.isMine ?
                        MyChatView(content: $0.message, timeLine: $0.sendAt):
                        SenderChatView(content: $0.message, timeLine: $0.sendAt)
                        owner.chatContentStackView.addArrangedSubview(inputView)
                    }
                }
            )
            .disposed(by: disposeBag)
    }
    
    public override func addView() {
        [
            scrollBackgroundView,
            placeHolderImageView,
            placeHolderLabel,
            sendBackgroundView,
            navigationBarBackgroundView
        ].forEach({ view.addSubview($0) })
        scrollBackgroundView.addSubview(chatScrollerView)
        chatTextField.addSubview(sendChatButton)
        sendBackgroundView.addSubview(chatTextField)
        chatScrollerView.addSubview(chatContentStackView)
    }
    
    public override func setLayout() {
        navigationBarBackgroundView.snp.makeConstraints {
            $0.top.width.equalToSuperview()
            $0.height.equalTo(view.safeAreaInsets.top)
        }
        sendBackgroundView.snp.makeConstraints {
            $0.width.bottom.equalToSuperview()
            $0.height.equalTo(99)
        }
        scrollBackgroundView.snp.makeConstraints {
            let hight = view.frame.height - view.safeAreaInsets.top - sendBackgroundView.frame.height
            $0.width.equalToSuperview()
            $0.bottom.equalTo(sendBackgroundView.snp.top)
            $0.height.equalTo(hight)
        }
        chatScrollerView.snp.makeConstraints {
            $0.height.lessThanOrEqualToSuperview()
            $0.width.centerY.equalToSuperview()
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
            $0.left.right.equalToSuperview().inset(15)
            $0.top.equalToSuperview().inset(5)
        }
        placeHolderImageView.snp.makeConstraints {
            $0.width.height.equalTo(120)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-20)
        }
        placeHolderLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(placeHolderImageView.snp.bottom)
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
            sendBackgroundView.transform = CGAffineTransform(translationX: 0, y: moveTo)
            chatScrollerView.contentInset = .init(
                top: keyboardFrame.height - view.safeAreaInsets.bottom,
                left: 0,
                bottom: 20,
                right: 0
            )
            chatScrollerView.setContentOffset(
                .init(x: 0, y: moveTo - 10),
                animated: true
            )
        } else {
            sendBackgroundView.transform = .identity
            chatScrollerView.contentInset = .init(top: 10, left: 0, bottom: 20, right: 0)
        }
    }
}
