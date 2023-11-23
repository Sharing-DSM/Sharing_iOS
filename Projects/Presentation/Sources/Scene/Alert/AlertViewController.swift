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
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
    }

    private let titleLabel = UILabel().then {
        $0.font = .headerH1Bold
        $0.textColor = .black900
        $0.textAlignment = .center
    }

    private let contentLabel = UILabel().then {
        $0.font = .bodyB1Medium
        $0.textColor = .black600
        $0.textAlignment = .center
        $0.numberOfLines = .max
    }

    private let alertButton = FillButton(type: .system).then {
        $0.setTitle("확인", for: .normal)
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
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
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
            $0.bottom.greaterThanOrEqualTo(alertButton.snp.bottom).offset(16)
            $0.center.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.left.right.equalToSuperview().inset(15)
        }

        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(15)
        }

        alertButton.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.left.right.equalToSuperview().inset(16)
            $0.top.greaterThanOrEqualTo(contentLabel.snp.bottom).offset(16)
        }
    }
}
