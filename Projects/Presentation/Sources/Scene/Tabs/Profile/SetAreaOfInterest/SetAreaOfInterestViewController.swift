import Core
import UIKit
import Then
import SnapKit
import SharingKit

public class SetAreaOfInterestViewController: BaseVC<SetAreaOfIntrestViewModel> {

    private let headerLabel = UILabel().then {
        $0.text = "관심지역 설정"
        $0.font = .headerH1SemiBold
        $0.textColor = .main
    }
    private let addressHelper: AddressHelperViewController
    private let addressStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 14
    }
    private let addressMarkLabel = UILabel().then {
        $0.text = "활동 주소"
        $0.textColor = .black900
        $0.font = .bodyB2Medium
    }
    private let selectAddressLabel = UILabel().then {
        $0.textColor = .black900
        $0.font = .bodyB2Medium
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    private let selectAddressBackground = UIView().then {
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black800?.cgColor
        $0.layer.cornerRadius = 10
        $0.isHidden = true
    }
    private let addressSearchButton = UIButton(type: .system).then {
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.setTitle("주소 검색하기", for: .normal)
        $0.setTitleColor(UIColor.black800, for: .normal)
        $0.titleLabel?.font = .bodyB2Medium
    }
    private let completeButton = FillButton(type: .system).then {
        $0.setTitle("주소 설정완료", for: .normal)
    }
    public init(viewModel: SetAreaOfIntrestViewModel,addressHelper: AddressHelperViewController) {
        self.addressHelper = addressHelper
        self.addressHelper.modalPresentationStyle = .overFullScreen
        self.addressHelper.modalTransitionStyle = .crossDissolve
        super.init(viewModel: viewModel)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func bind() {
        let input = SetAreaOfIntrestViewModel.Input(
            addressData: addressHelper.selectAddress.asObservable(),
            completeButtonDidTap: completeButton.rx.tap.asObservable()
        )
        _ = viewModel.transform(input: input)

        addressSearchButton.rx.tap
            .subscribe(
                with: self,
                onNext: { owner, _ in
                    owner.present(owner.addressHelper, animated: true)
                }
            )
            .disposed(by: disposeBag)

        addressHelper.selectAddress
            .compactMap { $0 }
            .subscribe(
                with: self,
                onNext: { owner, data in
                    owner.selectAddressBackground.isHidden = false
                    owner.addressSearchButton.setTitle("주소 수정하기", for: .normal)
                    owner.selectAddressLabel.text = data.buildingName.isEmpty ?
                    data.roadAddressName : "\(data.roadAddressName)(\(data.buildingName))"
                }
            )
            .disposed(by: disposeBag)
    }

    public override func addView() {
        selectAddressBackground.addSubview(selectAddressLabel)
        [
            selectAddressBackground,
            addressSearchButton
        ].forEach { addressStackView.addArrangedSubview($0) }
        [
            headerLabel,
            addressMarkLabel,
            addressStackView,
            completeButton
        ].forEach { view.addSubview($0) }
    }
    public override func setLayout() {
        headerLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(90)
            $0.leading.equalToSuperview().inset(25)
            $0.height.equalTo(30)
        }

        addressMarkLabel.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom).offset(15)
            $0.leading.equalToSuperview().inset(25)
            $0.height.equalTo(20)
        }
        selectAddressLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.leading.trailing.equalToSuperview().inset(15)
        }
        addressStackView.snp.makeConstraints {
            $0.top.equalTo(addressMarkLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(25)
        }
        selectAddressBackground.snp.makeConstraints {
            $0.top.equalTo(addressStackView)
            $0.width.equalToSuperview()
            $0.bottom.equalTo(selectAddressLabel.snp.bottom).offset(24)
        }
        addressSearchButton.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(40)
        }

        completeButton.snp.makeConstraints {
            $0.top.equalTo(addressStackView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(40)
        }

    }
}
