import UIKit
import SnapKit
import SharingKit
import Then
import RxSwift

public class MapPostViewController: BaseVC<MapViewModel> {

    let postTableView = UITableView().then {
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .black50
        $0.separatorStyle = .none
        $0.register(MapPostTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(MapPostTableViewCell.self))
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black50
        postTableView.delegate = self
        postTableView.dataSource = self
    }

    public override func addView() {
        view.addSubview(postTableView)
    }

    public override func setLayout() {
        postTableView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(35)
            $0.left.right.equalToSuperview()
            $0.bottom.greaterThanOrEqualToSuperview()
        }
    }
}

extension MapPostViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(MapPostTableViewCell.self), for: indexPath) as? MapPostTableViewCell else { return UITableViewCell() }
        
        cell.settingCell(
            title: "어르신 휠체어 이동 도움 및 보조 활동",
            address: "유성구 전민동",
            tags: ["생활편의 지원", "노인 보조"]
        )

        return cell
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
