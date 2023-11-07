import UIKit
import SnapKit
import Then
import SharingKit
import RxFlow
import RxSwift
import RxCocoa
import Core
import Domain


public class HomeViewController: UIViewController {

    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        popularTableView.delegate = self
        popularTableView.dataSource = self
        areaOfInterstTableView.delegate = self
        areaOfInterstTableView.dataSource = self
    }

    // TODO: 나중에 baseview 넣기
    public override func viewWillLayoutSubviews() {
        addView()
        setLayout()
    }

    private let scrollView = UIScrollView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentInsetAdjustmentBehavior = .never
        $0.showsVerticalScrollIndicator = false
    }
    private let contentView = UIView()
    private let bannerView = BannerView().then {
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.error?.cgColor
        $0.backgroundColor = .black50
        $0.setShadow()
    }
    private let searchBarTextField = SearchBarTextField().then {
        $0.layer.cornerRadius = 25
    }
    private let popularHeaderLabel = UILabel().then {
        $0.text = "인기 자원봉사"
        $0.font = .headerH3SemiBold
        $0.textColor = .black900
    }
    private let popularTableView = UITableView().then {
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 105
        $0.contentInset = .init(top: 5, left: 0, bottom: 10, right: 0)
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = false
        $0.separatorStyle = .none
        $0.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.id)
    }
    private let areaOfInterstTableView = UITableView().then {
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 105
        $0.contentInset = .init(top: 5, left: 0, bottom: 10, right: 0)
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = false
        $0.separatorStyle = .none
        $0.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.id)
    }
    
    private let areaOfInterestHeaderLabel = UILabel().then {
        $0.text = "관심지역 자원봉사"
        $0.font = .headerH3SemiBold
        $0.textColor = .black900
    }

    private let writePostButton = GradationButton(type: .system).then {
        $0.setImage(.pencil.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
    }
    func addView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [
            bannerView,
            searchBarTextField,
            popularHeaderLabel,
            popularTableView,
            areaOfInterestHeaderLabel,
            areaOfInterstTableView,
            writePostButton
        ].forEach{ contentView.addSubview($0) }
    }
    func setLayout() {
        scrollView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints {
            $0.top.width.equalToSuperview()
            $0.bottom.greaterThanOrEqualToSuperview()
            $0.bottom.equalTo(areaOfInterstTableView.snp.bottom).offset(30)
        }
        bannerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview().inset(25)
            $0.height.equalTo(103)
        }
        searchBarTextField.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(25)
            $0.top.equalTo(bannerView.snp.bottom).offset(15)
        }
        popularHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(searchBarTextField.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(26)
        }
        popularTableView.snp.makeConstraints {
            $0.top.equalTo(popularHeaderLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(popularTableView.contentSize.height + 5)
        }
        areaOfInterestHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(popularTableView.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(bannerView)
        }
        areaOfInterstTableView.snp.makeConstraints {
            $0.top.equalTo(areaOfInterestHeaderLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(areaOfInterstTableView.contentSize.height + 5)
        }
        writePostButton.snp.makeConstraints {
            $0.width.height.equalTo(70)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == popularTableView {
            return 2
        } else if tableView == areaOfInterstTableView {
            return 5
        } else {
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.id, for: indexPath) as? PostTableViewCell else { return UITableViewCell() }

        cell.settingCell(
            title: "어르신 휠체어 이동 도움 및 보조 활동",
            address: "유성구 전민동",
            tags: ["생활편의 지원", "노인 보조"],
            cellId: "asfd",
            backgroundColor: .black50
        )

        return cell
    }
}
