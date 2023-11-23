import UIKit
import SharingKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import Domain
import Core

public class AddressHelperViewController: BaseVC<AddressViewModel> {

    public let selectAddress = BehaviorRelay<AddressEntityElement?>(value: nil)

    private let searchBar = SearchBarTextField().then {
        $0.placeholder = "주소를 검색해주세요(도로명, 지번)"
        $0.layer.cornerRadius = 10
    }

    private let tapBackgroundView = UIView().then {
        $0.backgroundColor = .clear
    }

    private let pageBackgroundView = UIView().then {
        $0.backgroundColor = .black50
        $0.layer.cornerRadius = 10
    }

    private let addressTableView = UITableView().then {
        $0.backgroundColor = .black50
        $0.isScrollEnabled = false
        $0.layer.cornerRadius = 10
        $0.separatorColor = .black500
        $0.separatorInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        $0.rowHeight = UITableView.automaticDimension
        $0.register(AddressTableViewCell.self, forCellReuseIdentifier: AddressTableViewCell.identifier)
    }

    private let pageLeftButton = UIButton(type: .system).then {
        $0.setImage(.pageLeftArrow, for: .normal)
        $0.tintColor = .black500
    }

    private let pageRightButton = UIButton(type: .system).then {
        $0.setImage(.pageRightArrow, for: .normal)
        $0.tintColor = .black500
    }

    private let pageCountLabel = UILabel().then {
        $0.text = "- / -"
        $0.font = .bodyB3Bold
        $0.textColor = .black900
    }

    public override func attribute() {
        view.backgroundColor = .black.withAlphaComponent(0.4)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        tap.cancelsTouchesInView = false
        tapBackgroundView.addGestureRecognizer(tap)
    }

    public override func bind() {
        let input = AddressViewModel.Input(
            searchButtonDidClick: searchBar.searchButton.rx.tap.asObservable(),
            searchBarText: searchBar.rx.text.orEmpty.asObservable(),
            leftPageButttoDidClick: pageLeftButton.rx.tap.asObservable(),
            rightPageButttoDidClick: pageRightButton.rx.tap.asObservable()
        )
        let output = viewModel.transform(input: input)

        output.addressDatas.asObservable()
            .bind(to: addressTableView.rx.items(cellIdentifier: AddressTableViewCell.identifier, cellType: AddressTableViewCell.self)) { row, element, cell in
                cell.roadAddressLabel.text = element.buildingName.isEmpty ?
                element.roadAddressName : "\(element.roadAddressName)(\(element.buildingName))"
                cell.addressNameLabel.text = element.addressName
                cell.addressData = element
                cell.setup()
            }
            .disposed(by: disposeBag)

        output.totalPage.asObservable()
            .bind(to: pageCountLabel.rx.text)
            .disposed(by: disposeBag)

        output.isEndOfLeftPage.asObservable()
            .bind(
                with: self,
                onNext: { owner, status in
                    owner.pageLeftButton.tintColor = status ? .black500 : .black900
                    owner.pageLeftButton.isEnabled = !status
                }
            )
            .disposed(by: disposeBag)

        output.isEndOfRightPage.asObservable()
            .bind(
                with: self,
                onNext: { owner, status in
                    owner.pageRightButton.tintColor = status ? .black500 : .black900
                    owner.pageRightButton.isEnabled = !status
                }
            )
            .disposed(by: disposeBag)

        addressTableView.rx.itemSelected
            .map { index -> AddressEntityElement? in
                guard let cell = self.addressTableView.cellForRow(at: index) as? AddressTableViewCell else { return nil }
                return cell.addressData
            }
            .compactMap { $0 }
            .subscribe(
                with: self,
                onNext: { owner, data in
                    owner.selectAddress.accept(data)
                    owner.dismiss(animated: true)
                }
            )
            .disposed(by: disposeBag)
    }

    public override func addView() {
        [
            tapBackgroundView,
            searchBar,
            pageBackgroundView
        ].forEach { view.addSubview($0) }
        [
            addressTableView,
            pageLeftButton,
            pageRightButton,
            pageCountLabel
        ].forEach { pageBackgroundView.addSubview($0) }
    }

    override public func setLayout() {
        tapBackgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        searchBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(view.frame.height / 4)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(50)
        }
        pageBackgroundView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.top.equalTo(searchBar.snp.bottom).offset(15)
            $0.height.greaterThanOrEqualTo(300)
            $0.bottom.equalTo(pageCountLabel.snp.bottom).offset(3)
        }
        addressTableView.snp.makeConstraints {
            $0.top.width.equalToSuperview()
            $0.height.greaterThanOrEqualTo(addressTableView.contentSize.height)
        }
        pageCountLabel.snp.makeConstraints {
            $0.height.equalTo(18)
            $0.top.equalTo(addressTableView.snp.bottom).offset(14)
            $0.centerX.equalToSuperview()
        }
        pageRightButton.snp.makeConstraints {
            $0.leading.equalTo(pageCountLabel.snp.trailing).offset(10)
            $0.centerY.equalTo(pageCountLabel)
            $0.width.height.equalTo(10)
        }
        pageLeftButton.snp.makeConstraints {
            $0.trailing.equalTo(pageCountLabel.snp.leading).offset(-10)
            $0.centerY.equalTo(pageCountLabel)
            $0.width.height.equalTo(10)
        }
    }

    @objc private func dismissView() {
        dismiss(animated: true)
    }
}
