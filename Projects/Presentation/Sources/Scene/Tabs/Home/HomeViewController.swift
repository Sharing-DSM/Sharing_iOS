import UIKit
import SnapKit
import Then
import SharingKit
import RxFlow
import RxSwift
import RxCocoa
import Core
import Domain


public class HomeViewController: BaseVC<HomeViewModel> {

    private let viewWillAppearRelay = PublishRelay<Void>()
    private let showDetailPostRelay = PublishRelay<String>()

    private let scrollView = UIScrollView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentInsetAdjustmentBehavior = .never
        $0.showsVerticalScrollIndicator = false
    }
    private let contentView = UIView()

    private let bannerView = BannerView()

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
        $0.contentInset = .init(top: 5, left: 0, bottom: 10, right: 0)
        $0.isScrollEnabled = false
        $0.separatorStyle = .none
        $0.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
    }
    private let areaOfInterstTableView = UITableView().then {
        $0.rowHeight = UITableView.automaticDimension
        $0.contentInset = .init(top: 5, left: 0, bottom: 10, right: 0)
        $0.isScrollEnabled = false
        $0.separatorStyle = .none
        $0.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
    }
    
    private let areaOfInterestHeaderLabel = UILabel().then {
        $0.text = "관심지역 자원봉사"
        $0.font = .headerH3SemiBold
        $0.textColor = .black900
    }

    private let writePostButton = GradationButton(type: .system).then {
        $0.setImage(.pencil.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
    }

    public override func viewDidAppear(_ animated: Bool) {
        bannerView.setContentOffset(
            .init(x: bannerView.frame.width, y: bannerView.contentOffset.y),
            animated: false
        )
    }

    public override func viewWillAppear(_ animated: Bool) {
        viewWillAppearRelay.accept(())
    }

    public override func attribute() {
        view.backgroundColor = .white
        bannerView.delegate = self
    }

    public override func bind() {
        let input = HomeViewModel.Input(
            viewWillApper: viewWillAppearRelay.asObservable(),
            showDetailPost: showDetailPostRelay.asObservable(),
            writePostButtonDidClick: writePostButton.rx.tap.asObservable()
        )
        let output = viewModel.transform(input: input)

        output.popularityPostData.asObservable()
            .bind(to: popularTableView.rx.items(
                cellIdentifier: PostTableViewCell.identifier,
                cellType: PostTableViewCell.self)) { [weak self] row, element, cell in
                    guard let self = self else { return }
                    cell.postTitleLable.text = element.title
                    cell.addressLable.text = element.addressName
                    cell.tagView.setTag(element.type.toTagName)
                    
                    cell.cellBackgroundView.backgroundColor = .black50
                    cell.cellId = element.id

                    cell.setup()

                    popularTableView.snp.updateConstraints {
                        $0.height.greaterThanOrEqualTo(self.popularTableView.contentSize.height + 5)
                    }
                }
                .disposed(by: disposeBag)

        popularTableView.rx.itemSelected
            .map { index -> String in
                guard let cell = self.popularTableView.cellForRow(at: index) as? PostTableViewCell else { return "" }
                return cell.cellId ?? ""
            }
            .bind(to: showDetailPostRelay)
            .disposed(by: disposeBag)

        output.areaOfInterestPostData.asObservable()
            .bind(to: areaOfInterstTableView.rx.items(
                cellIdentifier: PostTableViewCell.identifier,
                cellType: PostTableViewCell.self)) {[weak self] row, element, cell in
                    guard let self = self else { return }
                    
                    cell.postTitleLable.text = element.title
                    cell.addressLable.text = element.addressName
                    cell.tagView.setTag(element.type.toTagName)
                    cell.cellBackgroundView.backgroundColor = .black50
                    cell.cellId = element.id
                    cell.setup()
                    areaOfInterstTableView.snp.updateConstraints {
                        $0.height.greaterThanOrEqualTo(self.areaOfInterstTableView.contentSize.height + 5)
                    }
                }
                .disposed(by: disposeBag)

        areaOfInterstTableView.rx.itemSelected
            .map { index -> String in
                guard let cell = self.areaOfInterstTableView.cellForRow(at: index) as? PostTableViewCell else { return "" }
                return cell.cellId ?? ""
            }
            .bind(to: showDetailPostRelay)
            .disposed(by: disposeBag)

        output.emergencyPostData.asObservable()
            .map {
                var insertData = $0
                insertData.insert(insertData[insertData.count - 1], at: 0)
                insertData.append(insertData[1])
                return insertData
            }
            .bind(to: bannerView.rx.bannerSetter)
            .disposed(by: disposeBag)
    }

    public override func addView() {
        [
            scrollView,
            writePostButton
        ].forEach( { view.addSubview($0) })
        scrollView.addSubview(contentView)
        [
            bannerView,
            searchBarTextField,
            popularHeaderLabel,
            popularTableView,
            areaOfInterestHeaderLabel,
            areaOfInterstTableView
        ].forEach{ contentView.addSubview($0) }
    }

    public override func setLayout() {
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
            $0.height.greaterThanOrEqualTo(popularTableView.contentSize.height + 5)
        }
        areaOfInterestHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(popularTableView.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(bannerView)
        }
        areaOfInterstTableView.snp.makeConstraints {
            $0.top.equalTo(areaOfInterestHeaderLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.greaterThanOrEqualTo(areaOfInterstTableView.contentSize.height + 5)
        }
        writePostButton.snp.makeConstraints {
            $0.width.height.equalTo(70)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
    }
}

extension HomeViewController: UIScrollViewDelegate {
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        if scrollView.contentOffset.x <= 0 {
            scrollView.setContentOffset(
                .init(x: scrollView.frame.width * CGFloat(bannerView.bannerCount) , y: scrollView.contentOffset.y),
                animated: false
            )
        }

        if scrollView.contentOffset.x >= scrollView.frame.width * CGFloat(bannerView.bannerCount + 1) {
            scrollView.setContentOffset(
                .init(x: scrollView.frame.width, y: scrollView.contentOffset.y),
                animated: false
            )
        }
    }
}
