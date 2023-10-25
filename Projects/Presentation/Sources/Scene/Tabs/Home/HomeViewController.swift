import UIKit
import SnapKit
import Then
import SharingKit
import RxFlow
import RxSwift

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
        popularCollectionView.dataSource = self
        popularCollectionView.delegate = self
        areaOfInterstCollectionView.dataSource = self
        areaOfInterstCollectionView.delegate = self
        addView()
        setLayout()
    }
    private let scrollView = UIScrollView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.bounces = false
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
    private let searchTextField = UITextField().then {
        $0.layer.cornerRadius = 25
        $0.backgroundColor = .black50
        $0.addLeftAndRightView()
        $0.setShadow()
    }
    private let searchButton = UIButton(type: .system).then {
        $0.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        $0.tintColor = .main
    }
    private let popularHeaderLabel = UILabel().then {
        $0.text = "인기 자원봉사"
        $0.font = .headerH3SemiBold
        $0.textColor = .black900
    }
    private let flowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
        $0.minimumLineSpacing = 10
        $0.minimumInteritemSpacing = 0
    }
    private lazy var popularCollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout).then {
        $0.register(PopularCollectionViewCell.self, forCellWithReuseIdentifier: "PopularCollectionViewCell")
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = false
        $0.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    private let areaOfInterestHeaderLabel = UILabel().then {
        $0.text = "관심지역 자원봉사"
        $0.font = .headerH3SemiBold
        $0.textColor = .black900
    }
    private lazy var areaOfInterstCollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout).then {
        $0.register(AreaOfInterstCollectionViewCell.self, forCellWithReuseIdentifier: "AreaOfInterstCollectionViewCell")
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = false
        $0.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    private let writeButton = UIButton().then {
        $0.setImage(UIImage(systemName: "pencil"), for: .normal)
        $0.backgroundColor = .brown
    }
    func addView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [
            bannerView,
            searchTextField,
            searchButton,
            popularHeaderLabel,
            popularCollectionView,
            areaOfInterestHeaderLabel,
            areaOfInterstCollectionView
        ].forEach{ contentView.addSubview($0) }
    }
    func setLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.height.equalTo(1035)
            $0.width.equalToSuperview()
        }
        bannerView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(75)
            $0.leading.equalToSuperview().inset(26)
            $0.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(103)
        }
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(bannerView.snp.bottom).offset(15)
            $0.leading.trailing.equalTo(bannerView)
            $0.height.equalTo(49)
        }
        searchButton.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.top).offset(12)
            $0.trailing.equalTo(searchTextField.snp.trailing).offset(-20)
            $0.height.width.equalTo(25)
        }
        popularHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(26)
            $0.height.equalTo(26)
        }
        popularCollectionView.snp.makeConstraints {
            $0.top.equalTo(popularHeaderLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(329)
        }
        areaOfInterestHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(popularCollectionView.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(bannerView)
            $0.height.equalTo(26)
        }
        areaOfInterstCollectionView.snp.makeConstraints {
            $0.top.equalTo(areaOfInterestHeaderLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(329)
        }
    }
}

extension HomeViewController:  UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case popularCollectionView:
            return 4
        case areaOfInterstCollectionView:
            return 3
        default:
            return 4
        }
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case popularCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCollectionViewCell", for: indexPath)
            return cell
        case areaOfInterstCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AreaOfInterstCollectionViewCell", for: indexPath)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.bounds.width - 50, height: 91 )
    }
}
