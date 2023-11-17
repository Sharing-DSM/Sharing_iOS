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

    public override func attribute() {
        self.navigationItem.leftBarButtonItem = .init(customView: headerLabel)
        chatTableView.delegate = self
        chatTableView.dataSource = self
    }

    public override func addView() {
        view.addSubview(chatTableView)
    }

    public override func setLayout() {
        chatTableView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
        }
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.Identifier, for: indexPath) as? ChatTableViewCell else { return UITableViewCell() }
        if indexPath.row == 1 {
            cell.isDidNotRead = true
        }
        cell.setup()

        return cell
    }
}
