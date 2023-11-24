import UIKit
import SnapKit
import Then
import SharingKit
import RxFlow
import RxSwift
import RxCocoa
import Core
import Domain

public class ChatViewController: BaseVC<ChatViewModel> {
    
    private let fetchChatRoomList = PublishRelay<Void>()
    private let selectChatRoom = PublishRelay<String>()
    
    private let headerLabel = UILabel().then {
        $0.text = "채팅"
        $0.textColor = .black
        $0.font = .headerH1Bold
    }
    
    private let chatTableView = UITableView().then {
        $0.rowHeight = 90
        $0.backgroundColor = .white
        $0.separatorColor = .black600
        $0.separatorInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        $0.register(ChatTableViewCell.self, forCellReuseIdentifier: ChatTableViewCell.Identifier)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        fetchChatRoomList.accept(())
    }
    
    public override func attribute() {
        self.navigationItem.leftBarButtonItem = .init(customView: headerLabel)
    }
    
    public override func bind() {
        
        let input = ChatViewModel.Input(
            fetchChatRoomList: fetchChatRoomList.asObservable(),
            selectChatRoom: selectChatRoom.asObservable()
        )
        let output = viewModel.transform(input: input)
        
        chatTableView.rx.itemSelected
            .map { index -> String in
                guard let cell = self.chatTableView.cellForRow(at: index) as? ChatTableViewCell
                else { return "" }
                return cell.roomID
            }
            .bind(to: selectChatRoom)
            .disposed(by: disposeBag)
        
        output.chatRoomsData.asObservable()
            .bind(to: chatTableView.rx.items(
                cellIdentifier: ChatTableViewCell.Identifier,
                cellType: ChatTableViewCell.self)
            ) { (row, data, cell) in
                cell.isDidNotRead = !data.isRead
                cell.setup(
                    imageURL: data.userProfile,
                    roomName: data.roomName,
                    preview: data.lastChat,
                    sendAt: data.lastSendAt,
                    roomID: data.roomID
                )
            }
            .disposed(by: disposeBag)
    }
    
    public override func addView() {
        [
            chatTableView
        ].forEach({ view.addSubview($0) })
    }
    
    public override func setLayout() {
        chatTableView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
        }
    }
}
