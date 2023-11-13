import UIKit
import SharingKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import Core

public class AlertViewController: UIViewController, HasDisposeBag {

    public var disposeBag: DisposeBag = DisposeBag()

    private let alertBackGroundView = UIView().then {
        $0.layer.cornerRadius = 10
        $0.layer.opacity = 0
    }

    private let titleLabel = UILabel().then {
        $0.font = .headerH1Bold
        $0.textColor = .black900
        $0.layer.opacity = 0
    }

    private let contentLabel = UILabel().then {
        $0.font = .bodyB1SemiBold
        $0.textColor = .black600
        $0.textAlignment = .left
        $0.numberOfLines = .max
        $0.layer.opacity = 0
    }

    private let alertButton = FillButton(type: .system).then {
        $0.setTitle("확인", for: .normal)
        $0.layer.opacity = 0
    }

    public init(
        title: String?,
        content: String? = nil,
        backgroundColor: UIColor = .white
    ) {
        super.init(nibName: nil, bundle: nil)
        self.alertBackGroundView.backgroundColor = backgroundColor
        self.titleLabel.text = title
        self.contentLabel.text = content
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        alertButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.dismissAlertWithAnimation()
            })
            .disposed(by: disposeBag)
    }

    public override func viewDidAppear(_ animated: Bool) {
        showAlertWithAnimation()
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(alertBackGroundView)
        [
            titleLabel,
            contentLabel,
            alertButton
        ].forEach { alertBackGroundView.addSubview($0) }

        alertBackGroundView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(40)
            $0.top.equalTo(titleLabel.snp.top).offset(-18)
            $0.height.greaterThanOrEqualTo(182)
            $0.bottom.equalTo(alertButton.snp.bottom).offset(12)
            $0.center.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.left.right.equalToSuperview().inset(15)
        }

        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.left.right.equalToSuperview().inset(15)
        }

        alertButton.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.left.right.equalToSuperview().inset(15)
            $0.top.greaterThanOrEqualTo(contentLabel.snp.bottom).offset(30)
        }
    }
}

extension AlertViewController {
    private func showAlertWithAnimation() {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut) { [weak self] in
            self?.alertBackGroundView.layer.opacity = 1
            self?.alertBackGroundView.subviews.forEach { $0.layer.opacity = 1 }
        }
    }

    private func dismissAlertWithAnimation() {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: { [weak self] in
            self?.alertBackGroundView.layer.opacity = 0
            self?.alertBackGroundView.subviews.forEach { $0.layer.opacity = 0 }
        }, completion: { _ in
            self.dismiss(animated: false)
        })
    }
}
